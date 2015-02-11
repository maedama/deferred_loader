module DeferredLoader
  module Loader
    class ActiveRecordAssociation
      def initialize
        @loader = ActiveRecord::Associations::Preloader.new
      end

      def load(instances, association)
        not_loaded = instances.select {|t| ! t.association(association).loadeed? }
        @loader.preload(not_loaded, association)
        instances.map {|item| instance.send(association) }
      end
    end
  end
end
