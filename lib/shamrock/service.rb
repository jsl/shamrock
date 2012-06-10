module Shamrock
  class Service

    attr_reader :port, :url

    def initialize(rack_app,
                   handler = Rack::Handler::WEBrick,
                   monitor = Shamrock::Monitor)

      @rack_app = rack_app
      @handler  = handler
      @port     = Port.new
      @url      = "http://localhost:#{port.number}"
      @monitor  = monitor.new(Shamrock::Http.new(url))
    end

    def start
      @thread = Thread.new do
        @handler.run(@rack_app, Port: port.number)
      end

      @monitor.wait_until_ready
    end

    def stop
      Thread.kill(@thread)
    end

    private

    def server_name
      @rack_app.class.name
    end
  end
end