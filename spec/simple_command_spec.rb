require 'spec_helper'

class TestCommand
  prepend SimpleCommand

  def initialize(input)
    @input = input
  end

  def perform
    @input * 2
  end
end

class FailTestCommand
  prepend SimpleCommand

  def initialize(input)
    @input = input
  end

  def perform
    add_error(:wrong_math, 'Math is not an opinion') if true
  end
end

describe SimpleCommand do
  let(:command) { TestCommand.new(2) }
  let(:fail_command) { FailTestCommand.new(2) }

  describe '#perform' do
    it 'returns the self object' do
      expect(command.perform).to be_a(TestCommand)
    end
  end

  describe '#success?' do
    it 'is true by default' do
      expect(command.perform.success?).to be_truthy
    end

    it 'is false when something went wrong' do
      expect(fail_command.perform.success?).to be_falsy
    end
  end

  describe '#errors' do
    context 'with no errors' do
      it 'returns an empty Hash' do
        errors = command.perform.errors

        expect(errors).to be_empty
      end
    end

    context 'with errors' do
      let(:errors) { fail_command.perform.errors }

      it 'returns an Hash' do
        puts errors.inspect
        expect(errors).to_not be_empty
      end

      it 'has a key with error message' do
        expect(errors).to have_key(:wrong_math)
        expect(errors[:wrong_math]).to_not be_nil
      end
    end
  end

  describe '#failure?' do
    it 'is false by default' do
      expect(command.perform.failure?).to be_falsy
    end

    it 'is true when something went wrong' do
      expect(fail_command.perform.failure?).to be_truthy
    end
  end

  describe '#result' do
    it 'returns the result of command execution' do
      expect(command.perform.result).to eq(4)
    end
  end

end
