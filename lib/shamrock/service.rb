require 'logger'

module Shamrock
  class Service

    attr_reader :port, :url

    PORT_RANGE = 9220..9260

    DEFAULT_OPTIONS = {
      handler: Rack::Handler::WEBrick,
      monitor: Shamrock::Monitor
    }

    def initialize(rack_app, options = {})
      @rack_app = rack_app

      options   = DEFAULT_OPTIONS.merge(options)

      @handler  = options[:handler]
      @logger   = logger

      @port     = options[:port] || random_port
      @url      = "http://localhost:#{port}"
      @monitor  = options[:monitor].new(Http.new(url))
    end

    def start
      @thread = Thread.new do
        @handler.run(@rack_app, Port: port, Logger: @logger)
      end

      @monitor.wait_until_ready
    end

    def stop
      Thread.kill(@thread)
    end

    private

    def logger
      defined? Rails ? Rails.logger : Logger.new(STDOUT)
    end

    def random_port
      Random.rand(PORT_RANGE)
    end

    def server_name
      @rack_app.class.name
    end
  end
end