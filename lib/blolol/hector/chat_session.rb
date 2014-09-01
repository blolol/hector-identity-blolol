require 'excon'
require 'json'

module Blolol
  module Hector
    class ChatSession
      DEFAULT_BASE_URL = 'https://api.blolol.com'

      def initialize(api_key, api_secret, username, password, base_url: nil)
        @authorization_header = "key=#{api_key} secret=#{api_secret}"
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
          'Authorization' => @authorization_header,
          'Content-Type' => 'application/json'
        }
      end

      def request_body
        {
          session: {
            username: @username,
            password: @password
          }
        }.to_json
      end

      def request_url
        "#{base_url}/v1/chat/sessions"
      end
    end
  end
end
