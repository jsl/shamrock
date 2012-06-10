require 'bundler/setup'
require 'shamrock'

describe "starting a service and making a request" do
  it "should respond successfully" do
    rack_app = proc {|env| [200, {"Content-Type" => "text/html"}, ["Hello Rack!"]]}
    service = Shamrock::Service.new(rack_app)
    service.start
    Net::HTTP.get(URI.parse("http://localhost:#{service.port}")).to_s.should == "Hello Rack!"
    service.stop
  end
end