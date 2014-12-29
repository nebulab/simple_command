class SuccessCommand
  prepend SimpleCommand

  def initialize(input)
    @input = input
  end

  def perform
    @input * 2
  end
end
