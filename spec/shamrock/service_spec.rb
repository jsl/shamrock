require 'spec_helper'

describe Shamrock::Service do
  before do
    @rack_app = proc {|env| [200, {"Content-Type" => "text/html"}, "Hello Rack!"]}
    @monitor = mock('monitor', wait_until_ready: true)
    @monitor_class = mock('monitor class', new: @monitor)
  end

  describe "#start" do
    it "should start the server" do
      handler = mock('handler')
      service = Shamrock::Service.new(@rack_app, handler, @monitor_class)
      handler.should_receive(:run).with(@rack_app, Port: service.port.number)
      service.start
    end

    it "should wait for the server to become available" do
      @monitor.should_receive(:wait_until_ready).once
      handler = mock('handler', run: true)
      Shamrock::Service.new(@rack_app, handler, @monitor_class).start
    end
  end
end

