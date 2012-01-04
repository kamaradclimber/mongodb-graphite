require 'rubygems'
require 'mongo'

require 'graphite'

graphite_server = ""

g = Graphite::Logger.new(graphite_server)



to_ignore =[ "set", "repl", "time","command","qr|qw","ar|aw"]
to_convert = ["mapped","vsize","res","netIn","netOut"]
prefix_common = "criteo.mongodb."


def convert(s)
  mul = case s[-1] 
        when "b"
          1
        when "k"
          1024
        when "g"
          1024 * 1024
        when "t"
          1024 * 1024 * 1024
        else 
          raise "not convertible"
        end
  s[0..-1].to_f * mul
end





@conn = Mongo::Connection.new


@isdbgrid  = {"isdbgrid" => 1}
if @conn["admin"].command(@isdbgrid)["ok"] == 1
  puts "mongos"
else 
  puts "not mongos"
end



puts @conn["config"]["shards"].find().each { |shard|  
  host,port =  shard["host"].split(/,|\//)[1].split(':')
  #puts "shard : ", host,port
  connHost = Mongo::Connection.new(host, port)
  connHost["admin"].command({ "isMaster" => 1 } )["hosts"].each { |slave|
    host, port = slave.split(':')
    headers, values = `mongostat -n 1 --host #{host} --port #{port}   `.split("\n")[1..2].map {|line| line.gsub(' %','%').gsub('*','').gsub('idx miss','idxmiss').split }
    prefix = prefix_common + host +"."+port+"."
    headers = headers.map { |key| prefix+key }
    metrics = Hash[headers.zip(values)]
    to_ignore.each { |key| metrics.delete(prefix + key) }
    to_convert.each {|key| metrics[prefix + key] = convert(metrics[prefix + key])}
    puts metrics
    g.log(`date +%s`, metrics)

  }
}


