require 'spec_helper'

describe Hector::BlololAuthenticationRequest do
  context '#success?' do
    before do
      @request = Hector::BlololAuthenticationRequest.new('auth_token', 'foo', 's3cr3t',
        base_url: 'http://example.com')
    end

    context 'when the authentication request fails' do
      before do
        stub_request(:post, 'http://example.com/chat/sessions').to_return status: 401
      end

      it 'returns false' do
        expect(@request).to_not be_success
      end
    end

    context 'when the authentication request succeeds' do
      before do
        stub_request(:post, 'http://example.com/chat/sessions').to_return status: 200
      end

      it 'returns true' do
        expect(@request).to be_success
      end
    end
  end
end
