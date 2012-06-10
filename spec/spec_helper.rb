require 'bundler/setup'

require 'simplecov'
SimpleCov.start

require 'shamrock'

# In-line the service startup for this test
class Shamrock::Service::Thread
  def initialize(&block)
    yield
  end
end
