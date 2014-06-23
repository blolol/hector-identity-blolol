require 'blolol/hector/chat_session'

module Blolol
  module Hector
    class IdentityAdapter
      attr_accessor :auth_token, :base_url

      def initialize(auth_token:, base_url: nil)
        @auth_token = auth_token
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
        ChatSession.new auth_token, username, password, base_url: base_url
      end
    end
  end
end
