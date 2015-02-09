[![Build Status](https://travis-ci.org/jsl/shamrock.svg?branch=master)](https://travis-ci.org/jsl/shamrock)

# Shamrock

Makes setting up stub services easy.

## Installation

Add this line to your application's Gemfile:

    gem 'shamrock'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shamrock

## Usage

You can then easily start the stub service either for the spec examples that need it, or
globally in your spec_helper file. You can replace the Proc below with any Rack application.
In some cases, we use Sinatra for stub services.

    my_rack_app = proc {|env| [200, {"Content-Type" => "text/html"}, ["Hello Rack!"]]}
    @service = Shamrock::Service.new(my_rack_app)
    @service.start
    @service.uri    # => #<URI::HTTP http://localhost:54321>

After you are done with the service:

    @service.stop

## Credits

Thanks to Wojciech Mach (http://github.com/wojtekmach) who helped to implement something like
this for a stub service on a project for Stack Builders.

Thanks to Mike Barinek for writing up an example of this code that used Threads for starting
the rack application - this gem draws from code in his blog post at
http://pivotallabs.com/users/mbarinek/blog/articles/2043-testing-ruby-services-without-mocks

Thanks to Kurt Eldridge (http://github.com/truk) for pair programming on a test problem with Threads.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
