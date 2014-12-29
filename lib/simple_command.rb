require "simple_command/version"
require "simple_command/errors"

module SimpleCommand

  def perform
    if !defined?(super)
      raise NotImplementedError
    end

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

  def result
    @result
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
