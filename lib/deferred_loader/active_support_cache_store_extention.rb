require 'active_support/concern'
module DeferredLoader
  module ActiveSupportCacheStoreExtention
    extend ActiveSupport::Concern

    included do      

      def read_with_deferred(keys)
        result = self.read_multi(*keys)
        keys.collect{|key| result[key] }
      end 
    end
  end
end
