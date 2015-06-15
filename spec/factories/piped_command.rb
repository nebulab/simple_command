class PipedCommand
  prepend SimpleCommand

  def initialize(input, add)
    @input = input
    @add = add
  end

  def call
    @input * 2 + @add
  end
end
