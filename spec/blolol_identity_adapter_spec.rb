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
    @adapter = Hector::BlololIdentityAdapter.new
  end

  context '#authenticate' do
    context 'when the auth token is invalid' do
      before do
        stub_request(:post, 'https://blolol.com/chat/sessions').
          with(headers: { 'Accept' => 'application/json' },
            query: { 'auth_token' => 'invalid', 'user' => {
            'username' => 'foo', 'password' => 's3cr3t' } }).
          to_return(status: :unauthorized, body: '{"error":"Invalid authentication token."')
      end

      it 'logs an error' do
        logger = double('logger')
        logger.should_receive(:error).with('BlololIdentityAdapter: Invalid authentication token')
        Hector.stub logger: logger

        @adapter.authenticate 'foo', 'correct'
      end

      it 'yields false' do
        expect { |block| @adapter.authenticate('foo', 'correct', &block) }.to yield_with_args(false)
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
        expect { |block| @adapter.authenticate('foo', 'wrong', &block) }.to yield_with_args(false)
      end
    end

    context 'when the credentials are correct' do
      before do
        stub_request(:post, 'https://blolol.com/chat/sessions').
          with(headers: { 'Accept' => 'application/json' },
            query: { 'auth_token' => 'valid', 'user' => {
            'username' => 'foo', 'password' => 's3cr3t' } }).
          to_return(status: :ok)
      end

      it 'yields true' do
        expect { |block| @adapter.authenticate('foo', 'correct', &block) }.to yield_with_args(true)
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
