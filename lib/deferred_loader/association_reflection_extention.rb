require 'active_support/concern'
module DeferredLoader
  module AssociationReflectionExtention
    def initialize(*args)
      super(*args) 
      self.active_record.define_association_with_deferred(self.name)
    end
  end
end
