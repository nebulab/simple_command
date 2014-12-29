require 'simplecov'

SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simple_command'

Dir[File.join(File.dirname(__FILE__), 'factories', '**/*.rb')].each { |f| require f }
