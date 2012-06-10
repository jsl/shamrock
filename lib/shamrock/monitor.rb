require 'timeout'

module Shamrock
  class Monitor

    DEFAULT_TIMEOUT = 10
    RE_CHECK_WAIT   = 0.1

    attr_reader :http

    def initialize(http)
      @http = http
    end

    def wait_until_ready
      Timeout::timeout(DEFAULT_TIMEOUT) do
        until http.ready? do
          sleep RE_CHECK_WAIT
        end
      end

    rescue Timeout::Error => error
      abort "Server never started!"
    end
  end
end