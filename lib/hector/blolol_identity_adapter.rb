require 'hector/blolol_authentication_request'

module Hector
  class BlololIdentityAdapter
    attr_accessor :auth_token, :base_url

    def initialize(auth_token:, base_url: nil)
      @auth_token = auth_token
      @base_url = base_url
    end

    def authenticate(username, password)
      yield authentication_request(username, password).success?
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

    def authentication_request(username, password)
      BlololAuthenticationRequest.new auth_token, username, password, base_url: base_url
    end
  end
end
