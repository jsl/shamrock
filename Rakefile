#!/usr/bin/env rake
require "bundler/gem_tasks"

require "rspec/core/rake_task"

namespace :spec do
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.pattern = Dir['spec/*/**/*_spec.rb']
  end

  RSpec::Core::RakeTask.new(:integration) do |t|
    t.pattern = "integration_spec/**/*_spec.rb"
  end
end

task :default => ["spec:unit", "spec:integration"]