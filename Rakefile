require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rake/manifest"

RSpec::Core::RakeTask.new(:spec)
Rake::Manifest::Task.new do |t|
  t.patterns = ["lib/**/*", "LICENSE.txt", "README.md"]
end

task :default => :spec
task :build => "manifest:check"
