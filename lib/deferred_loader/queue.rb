module DeferredLoader
  class Queue
    def initialize
      @grouped_queue = {}
    end

    def push_to_group(group_key, loader, group_opts, instance, &block) 
      @grouped_queue[group_key] ||= {
        loader: loader,
        items: [],
        group_opts: group_opts,
      }
      @group_queue[group_key].instances.push({ instance: instance, block: &block})
    end

    def pop_group
      key, val = @grouped_queue.shift
      return val[:loader], val[:group_opts], val[:items]
    end
  end
end
