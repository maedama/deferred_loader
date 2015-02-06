require 'active_support/notifications'
require 'deferred_loader/executable'
require 'q'
module DeferredLoader
  class Proxy
    def initialize(object)
      @object = object
    end
    
    def proxy(method, *args)
      raise "Currently do not support args with length  >= 2" if args.length >= 2

      Q.defer {|defer|
        DeferredLoader::Executable.find_or_create(@object, method).push(
          @object, args[0], defer
        )
      }
    end
    alias_method :method_missing, :proxy
  end
end
