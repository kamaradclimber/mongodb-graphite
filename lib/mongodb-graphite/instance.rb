require 'mongo'
require 'simple-graphite'

module Enumerable
  def merge_all
    self.inject({}) { |h1, h2|
      h1.merge! h2
    }
  end
end

module MongodbGraphite
  class Instance

    OPTIONS = [:host, :port, :prefix_callback, :fields_to_ignore]

    def initialize(name)
      @name = name
      @port = 27017
      @host = 'localhost'
      @fields_to_ignore = %w(host version process pid uptimeMillis localTime extra_info.note backgroundFlushing.last_finished repl.setName repl.hosts repl.arbiters repl.primary repl.me ok)
      @prefix_callback = nil
    end

    def reload(options)
      OPTIONS.each do |opt|
        val = instance_variable_get "@#{opt}"
        if options[opt] != val and not options[opt].nil?
          instance_variable_set "@#{opt}", options.delete(opt)
        end
      end
    end

    OPTIONS.each do |opt|
      define_method opt do
        instance_variable_get "@#{opt}"
      end
    end

    def to_s
      "#{@name} #{@host}:#{@port}, #{@prefix_callback.class}"
    end

    def to_graphite
      @stats = to_hash 
      with_prefix = Hash.new
      @stats.each do |k,v|
        with_prefix[ [prefix, k].join('.')] = to_i(v)
      end
      with_prefix.reject { |k,v| ignored_fields.include? k }
    end

    private

    def prefix
      return @prefix_callback.call(@stats) unless @prefix_callback.nil?
      nil
    end

    def to_i(v)
      return v.to_i if v.respond_to?('to_i')
      case v
      when TrueClass
        1
      when FalseClass
        0
      else
        nil
      end
    end

    def ignored_fields
      @fields_to_ignore.map { |f| [prefix,f].join('.') }
    end

    def connection
      @connection ||= Mongo::MongoClient.new(host, port, :slave_ok => true, :connect_timeout => 5, :pool_timeout => 5)
    end

    def stats
      connection['test'].command({ 'serverStatus' => 1})
    end

    def to_hash
      s = stats
      @process = s['process']
      json_descent([], s).flatten.merge_all
    end

    def json_descent(pre, json)
      json.map do |k,v|
        key = pre + [k]
        if v.is_a? BSON::OrderedHash
          json_descent(key, v)
        else
          {key.join('.') => v }
        end
      end
    end
  end
end
