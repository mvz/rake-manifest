# frozen_string_literal: true

require_relative "lib/rake/manifest/version"

Gem::Specification.new do |spec|
  spec.name = "rake-manifest"
  spec.version = Rake::Manifest::VERSION
  spec.authors = ["Matijs van Zuijlen"]
  spec.email = ["matijs@matijs.net"]

  spec.summary = "Rake tasks to generate and check a manifest file"
  spec.homepage = "https://github.com/mvz/rake-manifest"

  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mvz/rake-manifest"
  spec.metadata["changelog_uri"] = "https://github.com/mvz/rake-manifest/blob/master/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = File.read("Manifest.txt").split
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.72"
  spec.add_development_dependency "rubocop-packaging", "~> 0.6.0"
  spec.add_development_dependency "rubocop-performance", "~> 1.24"
  spec.add_development_dependency "rubocop-rake", "~> 0.7.1"
  spec.add_development_dependency "rubocop-rspec", "~> 3.5"
  spec.add_development_dependency "simplecov", "~> 0.22.0"
end
