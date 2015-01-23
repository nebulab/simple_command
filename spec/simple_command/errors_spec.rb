require 'spec_helper'

describe SimpleCommand::Errors do
  let(:errors) { SimpleCommand::Errors.new }

  describe '#add' do
    before do
      errors.add :some_error, 'some error description'
    end

    it 'adds the error' do
      expect(errors[:some_error]).to eq(['some error description'])
    end

    it 'adds the same error only once' do
      errors.add :some_error, 'some error description'
      expect(errors[:some_error]).to eq(['some error description'])
    end
  end

  describe '#add_multiple_errors' do
    let(:errors_list) do
      {
        some_error: ['some error description'],
        another_error: ['another error description']
      }
    end

    before do
      errors.add_multiple_errors errors_list
    end

    it 'populates itself with the added errors' do
      expect(errors[:some_error]).to eq(errors_list[:some_error])
      expect(errors[:another_error]).to eq(errors_list[:another_error])
    end
  end
end
