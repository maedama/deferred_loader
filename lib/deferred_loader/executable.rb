require 'active_support/notifications'
module DeferredLoader
  class Executable

    @@registry = {}

    def self.find_or_create(object, method)
      loader_method = method.to_s + "_with_deferred"
      loader = nil
      if object.respond_to?(loader_method) then
        loader = object
      elsif object.class.respond_to?(loader_method) then
        loader = object.class
      else
        raise "#{object.class} or #{object.to_s} does not respond do #{loader_method}"
      end
      
      key  = loader.object_id.to_s  + "\#" + loader_method.to_s
      @@registry[key] ||= self.new(loader, loader_method)
      return @@registry[key]
    end

    def initialize(loader, method)
      @arguments = []
      @defers = []
      @loader = loader
      @method = method
    end

    def push(object, argument, defer)
      if @loader.instance_of?(Class) then
        @arguments.push(object)
      else
        @arguments.push(argument)
      end
      @defers.push(defer)
    end

    def execute
      @results = @loader.send(@method, @arguments)
      @results.dup.zip @defers.dup.each do|res, defer|
        defer.resolve(res)
      end
    end

    def self.execute_all
      while (@@registry.size > 0) do
        id, executable = @@registry.shift
        executable.execute
      end
    end

    def clear
      @@registry.clear
    end
  end
end

