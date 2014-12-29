class FailCommand
  prepend SimpleCommand

  def initialize(input)
    @input = input
  end

  def perform
    add_error(:wrong_math, 'Math is not an opinion') if true
  end
end
