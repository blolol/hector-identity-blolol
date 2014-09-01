require 'blolol/hector/chat_session'

module Blolol
  module Hector
    class IdentityAdapter
      attr_accessor :api_key, :api_secret, :base_url

      def initialize(api_key:, api_secret:, base_url: nil)
        @api_key = api_key
        @api_secret = api_secret
        @base_url = base_url
      end

      def authenticate(username, password)
        yield chat_session(username, password).success?
      end

      def forget(username)
        false
      end

      def normalize(username)
        username
      end

      def remember(username, password)
        false
      end

      private

      def chat_session(username, password)
        ChatSession.new api_key, api_secret, username, password, base_url: base_url
      end
    end
  end
end
