require 'spec_helper'

describe Faraday::HttpError do
  describe '.from_response' do
    let(:error_message) { 'error message' }
    let(:version) { Faraday::HttpError::VERSION }
    let(:status) { 422 }
    let(:response) { { status: status, body: error_message } }
    let(:error) { Faraday::HttpError.from_response(response) }

    describe '#body' do
      it 'must be the original error message' do
        expect(error.body).to eq(error_message)
      end
    end

    describe '#message' do
      it 'must include the original error message' do
        expect(error.message).to include(error_message)
      end

      it 'must include the right error class' do
        expect(error.message).to include('Faraday::HttpError::UnprocessableEntity')
      end

      it 'must include the gem version' do
        expect(error.message).to include("version #{version}")
      end
    end

    describe '#initialize' do
      it 'accepts blank exception' do
        expect { Faraday::HttpError.new }.not_to raise_error
      end
    end
  end
end
