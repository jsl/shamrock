require 'spec_helper'

describe Shamrock::Monitor do
  describe "#wait_until_ready" do
    it "should check to see if the given url is available" do
      http = mock('http')
      http.should_receive(:ready?).and_return(true)

      monitor = Shamrock::Monitor.new(http)
      monitor.wait_until_ready
    end

    it "should check the http connection a second time if it is not ready at first" do
      http = mock('http')
      http.should_receive(:ready?).and_return(false, true)

      monitor = Shamrock::Monitor.new(http)
      monitor.wait_until_ready
    end
  end
end