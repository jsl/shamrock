require 'spec_helper'

describe Shamrock::Service do
  before do
    @rack_app = proc {|env| [200, {"Content-Type" => "text/html"}, "Hello Rack!"]}
  end

  describe "initialization" do
    it "should use a specific port if one is given in the initializer" do
      service = Shamrock::Service.new(@rack_app, port: 8080)
      service.port.should == 8080
    end

    it "should assign a random port of none is given to initializer" do
      service = Shamrock::Service.new(@rack_app)
      service.port.should_not be_nil
    end
  end

  describe "#start" do
    it "should start the server" do
      monitor = mock('monitor', wait_until_ready: true)
      monitor_class = mock('monitor class', new: monitor)

      handler = mock('handler')
      service = Shamrock::Service.new(@rack_app, handler: handler, monitor: monitor_class)
      handler.should_receive(:run).with(@rack_app, Port: service.port)
      service.start
    end

    it "should wait for the server to become available" do
      monitor = mock('monitor')
      monitor_class = mock('monitor class', new: monitor)

      monitor.should_receive(:wait_until_ready).once

      handler = mock('handler', run: true)
      Shamrock::Service.new(@rack_app, handler: handler, monitor: monitor_class).start
    end
  end
end

