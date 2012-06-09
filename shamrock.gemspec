# -*- encoding: utf-8 -*-
require File.expand_path('../lib/shamrock/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Justin S. Leitgeb"]
  gem.email         = ["justin@stackbuilders.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "shamrock"
  gem.require_paths = ["lib"]
  gem.version       = Shamrock::VERSION

  gem.add_dependency('rack')

  gem.add_development_dependency 'rake', '~> 0.9.2.2'
  gem.add_development_dependency 'rspec', '~> 2.10.0'
  gem.add_development_dependency 'simplecov', '~> 0.6.4'
end
