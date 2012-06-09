require 'spec_helper'

describe Shamrock::Monitor do
  describe "#wait_until_ready" do
    it "should check to see if the given url is available" do
      monitor = Shamrock::Monitor.new('http://example.com')
      monitor.should_receive(:ready?).and_return(true)
      monitor.wait_until_ready
    end
  end
end