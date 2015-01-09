require 'spec_helper'

describe SimpleCommand do
  let(:command) { SuccessCommand.new(2) }
  let(:fail_command) { FailCommand.new(2) }

  describe '.perform' do
    before do
      allow(SuccessCommand).to receive(:new).and_return(command)
      allow(command).to receive(:perform)

      SuccessCommand.perform 2
    end

    it 'initializes the command' do
      expect(SuccessCommand).to have_received(:new)
    end

    it 'calls #perform method' do
      expect(command).to have_received(:perform)
    end
  end

  describe '#perform' do
    let(:missed_perform_command) { MissedPerformCommand.new(2) }

    it 'returns the command object' do
      expect(command.perform).to be_a(SuccessCommand)
    end

    it 'raises an exception if the method is not defined in the command' do
      expect do
        missed_perform_command.perform
      end.to raise_error(SimpleCommand::NotImplementedError)
    end
  end

  describe '#success?' do
    it 'is true by default' do
      expect(command.perform.success?).to be_truthy
    end

    it 'is false if something went wrong' do
      expect(fail_command.perform.success?).to be_falsy
    end

    context 'when perform is not called yet' do
      it 'is false by default' do
        expect(command.success?).to be_falsy
      end
    end
  end

  describe '#result' do
    it 'returns the result of command execution' do
      expect(command.perform.result).to eq(4)
    end

    context 'when perform is not called yet' do
      it 'returns nil' do
        expect(command.result).to be_nil
      end
    end
  end

  describe '#failure?' do
    it 'is false by default' do
      expect(command.perform.failure?).to be_falsy
    end

    it 'is true if something went wrong' do
      expect(fail_command.perform.failure?).to be_truthy
    end

    context 'when perform is not called yet' do
      it 'is false by default' do
        expect(command.failure?).to be_falsy
      end
    end
  end

  describe '#errors' do
    let(:errors) { command.perform.errors }

    it 'returns an Hash' do
      expect(errors).to be_a(Hash)
    end

    context 'with no errors' do
      it 'returns an empty Hash' do
        expect(errors).to be_empty
      end
    end

    context 'with errors' do
      let(:errors) { fail_command.perform.errors }

      it 'has a key with error message' do
        expect(errors[:wrong_math]).to_not be_nil
      end
    end
  end
end
