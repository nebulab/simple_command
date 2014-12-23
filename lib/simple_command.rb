# TODO: use autoload
require "simple_command/version"
require "simple_command/errors"

module SimpleCommand

  def perform
    raise NotImplemented if !defined?(:super)

    @result = super

    self
  end

  def success?
    !failure?
  end

  def failure?
    errors.any?
  end

  def result
    @result
  end

  def errors
    @errors ||= {}
  end

  private

  def add_error(key, value)
    errors[key] ||= []
    errors[key] << value
  end
end
