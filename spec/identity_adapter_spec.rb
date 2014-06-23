require 'spec_helper'

describe Blolol::Hector::IdentityAdapter do
  before do
    @adapter = Blolol::Hector::IdentityAdapter.new(auth_token: 'valid',
      base_url: 'http://example.com')
  end

  context '#authenticate' do
    context 'when the authentication request fails' do
      before do
        request = double('ChatSession', success?: false)
        allow(@adapter).to receive(:chat_session).and_return(request)
      end

      it 'yields false' do
        expect { |b| @adapter.authenticate('foo', 'invalid', &b) }.to yield_with_args(false)
      end
    end

    context 'when the authentication request succeeds' do
      before do
        request = double('ChatSession', success?: true)
        allow(@adapter).to receive(:chat_session).and_return(request)
      end

      it 'yields true' do
        expect { |b| @adapter.authenticate('foo', 'valid', &b) }.to yield_with_args(true)
      end
    end
  end

  context '#forget' do
    it 'returns false' do
      expect(@adapter.forget('foo')).to eq(false)
    end
  end

  context '#normalize' do
    it 'returns the username' do
      expect(@adapter.normalize('foo')).to eq('foo')
    end
  end

  context '#remember' do
    it 'returns false' do
      expect(@adapter.remember('foo', 's3cr3t')).to eq(false)
    end
  end
end