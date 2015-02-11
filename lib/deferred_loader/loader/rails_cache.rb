module DeferredLoader
  module Loader
    class RailsCache
      def load(keys, fallback_loader)
        Rails.get_multi(keys) do|key|
        end
      end
    end
  end
end
