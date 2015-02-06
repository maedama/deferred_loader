module DeferredLoader
  class Railtie < ::Rails::Railtie
    initializer 'deferred_loader' do |_app|
      ActiveSupport.on_load(:active_record) do
        require 'deferred_loader/active_record_extention'
        require 'deferred_loader/association_reflection_extention'
        ::ActiveRecord::Base.send :include, DeferredLoader::ActiveRecordExtention

        ActiveRecord::Reflection::AssociationReflection.prepend(DeferredLoader::AssociationReflectionExtention)
      end  
      ActiveSupport.on_load(:before_initialize) do
        require 'deferred_loader/active_support_cache_store_extention'
        ::ActiveSupport::Cache::Store.send :include, DeferredLoader::ActiveSupportCacheStoreExtention
      end
    end
  end
end
