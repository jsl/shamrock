require 'spec_helper'

describe Shamrock::Http do
  describe "#ready?" do
    it "should be ready if the HTTP response is successful" do
      Net::HTTP.stub!(:get_response).and_return(Net::HTTPSuccess.new(nil, nil, nil))
      Shamrock::Http.new('http://example.com').should be_ready
    end

    it "should be ready if the HTTP response if the resource has been moved" do
      Net::HTTP.stub!(:get_response).and_return(Net::HTTPMovedPermanently.new(nil, nil, nil))
      Shamrock::Http.new('http://example.com').should be_ready
    end

    it "should not be ready if the HTTP request raises a SocketError" do
      Net::HTTP.stub!(:get_response).and_raise(SocketError)
      Shamrock::Http.new('http://example.com').should_not be_ready
    end

    it "should not be ready if the HTTP request raises a Errno::ECONNREFUSED" do
      Net::HTTP.stub!(:get_response).and_raise(Errno::ECONNREFUSED)
      Shamrock::Http.new('http://example.com').should_not be_ready
    end
  end
end