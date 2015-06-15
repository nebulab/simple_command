require 'simple_command/version'
require 'simple_command/errors'

module SimpleCommand
  attr_reader :result

  module ClassMethods
    def call(*args)
      new(*args).call
    end
  end

  def self.prepended(base)
    base.extend ClassMethods
  end

  def call
    fail NotImplementedError unless defined?(super)

    @called = true
    @result = super

    self
  end

  def pipe(command, *args)
    return command.call(self.result, *args) if self.success?

    # not very clean, but at least you can rescue the error and know which
    # command failed
    fail BrokenPipeError.new(self.class.name)
  end

  def success?
    called? && !failure?
  end

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
