
require 'active_support/concern'
require 'deferred_loader/proxy'
module DeferedLoader
  module Deferrable
    extend ActiveSupport::Concern
    included do
      def deferred_load
        DeferredLoader::Proxy.new(self)
      end
    end
  end
end
