class FailCommand
  prepend SimpleCommand

  def initialize(input)
    @input = input
  end

  def perform
    errors.add_error(:wrong_math, 'Math is not an opinion')
  end
end
