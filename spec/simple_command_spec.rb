require 'spec_helper'

describe SimpleCommand do
  let(:command) { SuccessCommand.new(2) }

  describe '.call' do
    it 'executes the command' do
      expect(SuccessCommand.call(2).result).to eq(4)
    end
  end

  describe '#call' do
    let(:missed_call_command) { MissedCallCommand.new(2) }

    it 'returns the command object' do
      expect(command.call).to be_a(SuccessCommand)
    end

    it 'executes the command' do
      expect(command.call.result).to eq(4)
    end

    it 'raises an exception if the method is not defined in the command' do
      expect do
        missed_call_command.call
      end.to raise_error(SimpleCommand::NotImplementedError)
    end
  end

  describe '#pipe' do
    it 'pipes parent result output to child command input' do
      expect(command.call.pipe(SuccessCommand).result).to eq(8)
    end

    it 'accepts optional additional args for the child command' do
      expect(command.call.pipe(PipedCommand, 2).result).to eq(10)
    end

    it 'raises an exception if the parent command has failed' do
      command.errors.add(:some_error, 'some message')
      expect do
        command.pipe(SuccessCommand)
      end.to raise_error(SimpleCommand::BrokenPipeError, 'SuccessCommand')
    end
  end

  describe '#success?' do
    it 'is true by default' do
      expect(command.call.success?).to be_truthy
    end

    it 'is false if something went wrong' do
      command.errors.add(:some_error, 'some message')
      expect(command.call.success?).to be_falsy
    end

    context 'when call is not called yet' do
      it 'is false by default' do
        expect(command.success?).to be_falsy
      end
    end
  end

  describe '#result' do
    it 'returns the result of command execution' do
      expect(command.call.result).to eq(4)
    end

    context 'when call is not called yet' do
      it 'returns nil' do
        expect(command.result).to be_nil
      end
    end
  end

  describe '#failure?' do
    it 'is false by default' do
      expect(command.call.failure?).to be_falsy
    end

    it 'is true if something went wrong' do
      command.errors.add(:some_error, 'some message')
      expect(command.call.failure?).to be_truthy
    end

    context 'when call is not called yet' do
      it 'is false by default' do
        expect(command.failure?).to be_falsy
      end
    end
  end

  describe '#errors' do
    it 'returns an SimpleCommand::Errors' do
      expect(command.errors).to be_a(SimpleCommand::Errors)
    end

    context 'with no errors' do
      it 'is empty' do
        expect(command.errors).to be_empty
      end
    end

    context 'with errors' do
      before do
        command.errors.add(:some_error, 'some message')
      end

      it 'has a key with error message' do
        expect(command.errors[:some_error]).to eq(['some message'])
      end
    end
  end
end
