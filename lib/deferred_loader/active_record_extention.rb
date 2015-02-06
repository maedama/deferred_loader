require 'active_support/concern'
require 'active_record/associations/preloader'
module DeferredLoader
  module ActiveRecordExtention
    extend ActiveSupport::Concern

    included do
      @@preloader = ActiveRecord::Associations::Preloader.new
      
      def self.define_association_with_deferred(association)
        define_singleton_method(association.to_s + "_with_deferred") do |instances|
          load_association_with_deferred(association, instances)
        end
      end
      
      def self.load_association_with_deferred(ass, instances)
        not_loaded = instances.select {|i| !i.association(ass).loaded? }
        @@preloader.preload(not_loaded, ass) 
        instances.collect {|i| i.send(ass) }
      end
    end
  end
end
