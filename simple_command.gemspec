# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_command/version'

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 2.6'
  s.name          = 'simple_command'
  s.version       = SimpleCommand::VERSION
  s.authors       = ['Andrea Pavoni']
  s.email         = ['andrea.pavoni@gmail.com']
  s.summary       = 'Easy way to build and manage commands (service objects)'
  s.description   = 'Easy way to build and manage commands (service objects)'
  s.homepage      = 'http://github.com/nebulab/simple_command'
  s.license       = 'MIT'

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(/^bin\//) { |f| File.basename(f) }
  s.test_files    = s.files.grep(/^(test|spec|features)\//)
  s.require_paths = ['lib']

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 3.1'
end
