require 'spec_helper'

describe Blolol::Hector::ChatSession do
  context '#success?' do
    before do
      @session = Blolol::Hector::ChatSession.new('api_key', 'api_secret', 'foo', 's3cr3t',
        base_url: 'http://api.example.com')
    end

    context 'when the authentication request fails' do
      before do
        stub_request(:post, 'http://api.example.com/v1/chat/sessions').
          with(headers: { authorization: 'key=api_key secret=api_secret' }).
          to_return status: 422
      end

      it 'returns false' do
        expect(@session).to_not be_success
      end
    end

    context 'when the authentication request succeeds' do
      before do
        stub_request(:post, 'http://api.example.com/v1/chat/sessions').
          with(headers: { authorization: 'key=api_key secret=api_secret' }).
          to_return status: 200
      end

      it 'returns true' do
        expect(@session).to be_success
      end
    end
  end
end
