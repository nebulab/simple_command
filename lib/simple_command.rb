require 'simple_command/version'
require 'simple_command/errors'

module SimpleCommand
  attr_reader :result

  module ClassMethods
    def call(*args, &block)
      new(*args).call(&block)
    end
  end

  def self.prepended(base)
    base.extend ClassMethods
  end

  def call
    fail NotImplementedError unless defined?(super)

    @called = true
    @result = super

    yield(self) if success? && block_given?

    self
  end

  def success?
    called? && !failure?
  end
  alias_method :successful?, :success?

  def failure?
    called? && errors.any?
  end

  def errors
    @errors ||= Errors.new
  end

  private

  def called?
    @called ||= false
  end
end
