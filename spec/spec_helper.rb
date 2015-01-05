require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simple_command'

Dir[File.join(File.dirname(__FILE__), 'factories', '**/*.rb')].each do |factory|
  require factory
end
