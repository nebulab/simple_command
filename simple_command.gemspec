# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_command/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = '~> 2.0'
  spec.name          = "simple_command"
  spec.version       = SimpleCommand::VERSION
  spec.authors       = ["Andrea Pavoni"]
  spec.email         = ["andrea.pavoni@gmail.com"]
  spec.summary       = %q{Easy way to build and manage commands (aka: service objects)}
  spec.description   = %q{Easy way to build and manage commands (aka: service objects)}
  spec.homepage      = "http://github.com/nebulab/simple_command"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
