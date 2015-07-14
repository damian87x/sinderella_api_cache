# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinderella_api_cache/version'

Gem::Specification.new do |spec|
  spec.name          = "sinderella_api_cache"
  spec.version       = SinderellaApiCache::VERSION
  spec.authors       = ["Damian Borek"]
  spec.email         = ["demianborek@gmail.com"]
  spec.summary       = %q{API cache helpers for Grape.}
  spec.description   = %q{API cache helpers for Grape.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency 'dalli'
  spec.add_runtime_dependency 'grape', '0.6.1'
  spec.add_runtime_dependency 'grape-entity','0.4.0'
  spec.add_runtime_dependency 'grape-swagger','0.8.0'
  spec.add_runtime_dependency 'garner','0.5.1'
end
