$:.unshift File.join(File.dirname(__FILE__), '../lib')
require 'hector/blolol_identity_adapter'
require 'webmock/rspec'

describe Hector::BlololIdentityAdapter do
  around :each do |example|
    EventMachine.run do
      example.run
      EventMachine.stop
    end
  end

  before do
    authentication_token = 'valid'
    @adapter = Hector::BlololIdentityAdapter.new(authentication_token)
  end

  context '#authenticate' do
    context 'when the auth token is invalid' do
      before do
        @adapter.authentication_token = 'invalid'

        stub_request(:post, 'https://blolol.com/chat/sessions').
          with(headers: { 'Accept' => 'application/json' },
            query: { 'auth_token' => 'invalid', 'user' => {
            'username' => 'foo', 'password' => 'valid' } }).
          to_return(status: :unauthorized, body: '{"error":"Invalid authentication token."')
      end

      it 'logs an error' do
        logger = double('logger')
        logger.should_receive(:error).with('BlololIdentityAdapter: Invalid authentication token')
        Hector.stub logger: logger

        @adapter.authenticate 'foo', 'valid'
      end

      it 'yields false' do
        expect { |block| @adapter.authenticate('foo', 'valid', &block) }.to yield_with_args(false)
      end
    end

    context 'when the credentials are incorrect' do
      before do
        stub_request(:post, 'https://blolol.com/chat/sessions').
          with(headers: { 'Accept' => 'application/json' },
            query: { 'auth_token' => 'valid', 'user' => {
            'username' => 'foo', 'password' => 'invalid' } }).
          to_return(status: :unauthorized)
      end

      it 'yields false' do
        expect { |block| @adapter.authenticate('foo', 'invalid', &block) }.to yield_with_args(false)
      end
    end

    context 'when the credentials are correct' do
      before do
        stub_request(:post, 'https://blolol.com/chat/sessions').
          with(headers: { 'Accept' => 'application/json' },
            query: { 'auth_token' => 'valid', 'user' => {
            'username' => 'foo', 'password' => 'valid' } }).
          to_return(status: :ok)
      end

      it 'yields true' do
        expect { |block| @adapter.authenticate('foo', 'valid', &block) }.to yield_with_args(true)
      end
    end
  end

  context '#forget' do
    it 'returns false' do
      expect(@adapter.forget('foo')).to eq(false)
    end
  end

  context '#remember' do
    it 'returns false' do
      expect(@adapter.remember('foo', 's3cr3t')).to eq(false)
    end
  end
end
