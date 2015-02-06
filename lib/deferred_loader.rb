require "deferred_loader/version"
require "deferred_loader/deferrable"
require "deferred_loader/railtie"

module DeferredLoader
  # Your code goes here...
  Object.send(:include, DeferedLoader::Deferrable)

end
