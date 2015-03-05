# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deferred_loader/version'

Gem::Specification.new do |spec|
  spec.name          = "deferred_loader"
  spec.version       = DeferredLoader::VERSION
  spec.authors       = ["maedama"]
  spec.email         = ["maedama85@gmail.com"]
  spec.summary       = %q{Defered loading Active records and other obejcts to avoid n+1 problem.}
  spec.description   = %q{Defered loading Active records and other obejcts to avoid n+1 problem.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "rails", "~> 4.1"
  spec.add_dependency "q-defer", "~> 0.0.1"
end
