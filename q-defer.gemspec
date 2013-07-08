# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'q/version'

Gem::Specification.new do |spec|
  spec.name          = "q-defer"
  spec.version       = Q::VERSION
  spec.authors       = ["Jonathan Clem"]
  spec.email         = ["jonathan@jclem.net"]
  spec.description   = %q{Q is a lightweight deferred library for Ruby.}
  spec.summary       = %q{Q is a lightweight deferred library for Ruby.}
  spec.homepage      = "https://github.com/jclem/q-defer"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
