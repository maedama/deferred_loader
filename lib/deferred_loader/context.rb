module DeferredLoad
  class Context
    def initialize
      @queue = DeferredLoad::Queue.new
    end

    def deferred(instance, opts, loader=DeferredLoad::Loader::ActiveRecordRelation, &block)
      
      group_key, group_opts = loader.group_by(instance, opts)
      group_key.prepend(loader.class.name + "#")

      @queue.push_to_group(group_key, loader, group_opts, instance, &block)
    end

    def resolve
      while(@queue.size > 0) do 
        loader, group_opts, items = @queue.pop_group
        instances = items.map {|item| item[:instance] }
        loaded = loader.load(instances, group_opts)

        resolver.resolve(items) do|item|
          item[:block].call(loaded.shift)
        end
      end
    end
  end
end
