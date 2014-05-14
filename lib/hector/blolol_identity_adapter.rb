module Hector
  class BlololIdentityAdapter
    attr_accessor :authentication_token

    def initialize(authentication_token)
      @authentication_token = authentication_token
    end

    def authenticate(username, password)
      # TODO
    end

    def forget(username)
      false
    end

    def remember(username, password)
      false
    end
  end
end
