require 'yaml'

module MongodbGraphite
  class Configuration
    def initialize(dir, yml)
      reload(dir, yml)
    end

    def reload(dir, yml)
      @config = {
        'log_dir' => 'log',
        'pid_dir' => 'pids',
        'graphite' => 'localhost:3333',
        'mongodb' => 'localhost:27017',
        'interval' => 3, #in seconds
        'instances_file' => nil,
        'daemon_name' => 'mongodb-graphite'
      }

      config_file_path = File.join(dir, 'config', yml)
      if File.exist? config_file_path
        config_file = YAML.load_file(config_file_path)
        @config.keys.each do |key|
          value = config_file[key.to_s]
          @config[key] = value unless value.nil?
        end
      end

      @config[:mongodb_graphite_dir] = dir

      ['log_dir', 'pid_dir', 'instances_file'].each do |k|
        @config[k] = File.absolute_path(@config[k], dir)
      end
    end

    def [](key)
      @config[key]
    end
  end
end
