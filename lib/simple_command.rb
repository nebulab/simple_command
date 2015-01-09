require 'simple_command/version'
require 'simple_command/errors'

module SimpleCommand
  attr_reader :result

  module ClassMethods
    def perform(*args)
      new(*args).perform
    end
  end

  def self.prepended(base)
    base.extend ClassMethods
  end

  def perform
    fail NotImplementedError unless defined?(super)

    @performed = true
    @result = super

    self
  end

  def success?
    performed? && !failure?
  end

  def failure?
    performed? && errors.any?
  end

  def errors
    @errors ||= {}
  end

  private

  def performed?
    @performed ||= false
  end

  def add_error(key, value)
    errors[key] ||= []
    errors[key] << value
  end
end
