class MissedCallCommand
  prepend SimpleCommand

  def initialize(input)
    @input = input
  end
end
