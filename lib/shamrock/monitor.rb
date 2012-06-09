require 'net/http'
require 'timeout'

module Shamrock
  class Monitor

    DEFAULT_TIMEOUT = 10
    RE_CHECK_WAIT   = 0.1

    def initialize(url)
      @uri = URI.parse(url)
    end

    def wait_until_ready
      Timeout::timeout(DEFAULT_TIMEOUT) do
        until server_started? do
          sleep RE_CHECK_WAIT
        end
      end

      puts "Started server #{server_name} on #{port.number}."

    rescue Timeout::Error => error
      abort "Server never started!"
    end

    def ready?
      begin
        response = Net::HTTP.get_response(@uri)
        response.is_a?(Net::HTTPSuccess)
      rescue SystemCallError => error
        false
      end
    end

    private

    def server_name
      @rack_app.class.name
    end

  end
end