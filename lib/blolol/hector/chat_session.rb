require 'excon'
require 'json'

module Blolol
  module Hector
    class ChatSession
      DEFAULT_BASE_URL = 'https://blolol.com'

      def initialize(auth_token, username, password, base_url: nil)
        @auth_token = auth_token
        @username = username
        @password = password
        @base_url = base_url || DEFAULT_BASE_URL
      end

      def success?
        response.status == 200
      end

      private

      def base_url
        @base_url.chomp '/'
      end

      def response
        Excon.post request_url, headers: request_headers, body: request_body
      end

      def request_headers
        {
          'Accept' => 'application/json',
          'Content-Type' => 'application/json'
        }
      end

      def request_body
        {
          auth_token: @auth_token,
          user: {
            username: @username,
            password: @password
          }
        }.to_json
      end

      def request_url
        "#{base_url}/chat/sessions"
      end
    end
  end
end
