module MongodbGraphite
  class InstanceList
    include Enumerable

    attr_accessor :instances

    def initialize(config)
      @config = config
      @instances = {}
      reload
    end

    def reload
      @instances = {}

      file = @config['instances_file']
      if not file.nil?
        #puts "Reading instance file from #{file}"
        instance_eval(File.read(file),file)
      end
    end

    def instance(name)
      @options = {}
      yield
      @instances[name] ||= Instance.new(name)
      @instances[name].reload(@options)
      @options = nil
    end

    #dynamic definition of properties to have a nice dsl
    Instance::OPTIONS.each do |opt|
      define_method opt do |v|
        @options[opt] = v
      end
    end


    def each
      @instances.each do |name,i|
        yield i
      end
    end

  end
end
