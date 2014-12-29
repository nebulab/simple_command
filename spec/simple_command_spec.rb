require 'spec_helper'

describe SimpleCommand do
  let(:command) { SuccessCommand.new(2) }
  let(:fail_command) { FailCommand.new(2) }

  describe '#perform' do
    it 'returns the self object' do
      expect(command.perform).to be_a(SuccessCommand)
    end
  end

  describe '#success?' do
    context 'when #perform was called' do
      it 'is true by default' do
        expect(command.perform.success?).to be_truthy
      end

      it 'is false if something went wrong' do
        expect(fail_command.perform.success?).to be_falsy
      end
    end

    context 'when perform is not called yet' do
      it 'is false by default' do
        expect(command.success?).to be_falsy
      end
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
        expect(errors).to_not be_empty
      end

      it 'has a key with error message' do
        expect(errors[:wrong_math]).to_not be_nil
      end
    end
  end

  describe '#failure?' do
    context 'when #perform was called' do
      it 'is false by default' do
        expect(command.perform.failure?).to be_falsy
      end

      it 'is true if something went wrong' do
        expect(fail_command.perform.failure?).to be_truthy
      end
    end

    context 'when perform is not called yet' do
      it 'is false by default' do
        expect(command.failure?).to be_falsy
      end
    end
  end

  describe '#result' do
    it 'returns the result of command execution' do
      expect(command.perform.result).to eq(4)
    end
  end

end
