# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rake/manifest"

RSpec::Core::RakeTask.new(:spec)

Rake::Manifest::Task.new do |t|
  t.patterns = ["lib/**/*", "LICENSE.txt", "*.md"]
end

Rake::Task[:build].enhance ["manifest:check"]

task default: :spec
