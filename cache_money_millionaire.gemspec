# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cache_money_millionaire/version'

Gem::Specification.new do |spec|
  spec.name          = "cache_money_millionaire"
  spec.version       = CacheMoneyMillionaire::VERSION
  spec.authors       = ["John Koht"]
  spec.email         = ["john@kohactive.com"]
  spec.description   = "Rails ActiveRecord Query Caching like a Millionaire"
  spec.summary       = "Rails ActiveRecord Query Caching like a Millionaire"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
