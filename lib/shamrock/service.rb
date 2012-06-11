module Shamrock
  class Service

    attr_reader :port, :url

    DEFAULT_OPTIONS = {
      handler: Rack::Handler::WEBrick,
      monitor: Shamrock::Monitor
    }

    def initialize(rack_app, options = {})
      @rack_app = rack_app

      options   = DEFAULT_OPTIONS.merge(options)

      @handler  = options[:handler]

      @port     = options[:port] || find_available_port
      @url      = "http://localhost:#{port}"
      @monitor  = options[:monitor].new(Http.new(url))
    end

    def start
      @thread = Thread.new do
        @handler.run(@rack_app, Port: port)
      end

      @monitor.wait_until_ready
    end

    def stop
      Thread.kill(@thread)
    end

    private

    def find_available_port
      server = TCPServer.new('127.0.0.1', 0)
      server.addr[1]
    ensure
      server.close if server
    end

    def server_name
      @rack_app.class.name
    end
  end
end
