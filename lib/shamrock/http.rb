require 'net/http'

module Shamrock
  class Http

    attr_reader :uri

    def initialize(uri)
      @uri = uri
    end

    def ready?
      Net::HTTP.get_response(uri)
      true

    rescue SystemCallError, SocketError
      false
    end
  end
end
