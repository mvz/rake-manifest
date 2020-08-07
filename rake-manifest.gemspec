# frozen_string_literal: true

require_relative "lib/rake/manifest/version"

Gem::Specification.new do |spec|
  spec.name          = "rake-manifest"
  spec.version       = Rake::Manifest::VERSION
  spec.authors       = ["Matijs van Zuijlen"]
  spec.email         = ["matijs@matijs.net"]

  spec.summary       = "Rake tasks to generate and check a manifest file"
  spec.homepage      = "https://github.com/mvz/rake-manifest"
  spec.license       = "MIT"

  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mvz/rake-manifest"
  spec.metadata["changelog_uri"] = "https://github.com/mvz/rake-manifest/blob/master/CHANGELOG.md"

  spec.files = File.read("Manifest.txt").split
  spec.require_paths = ["lib"]

  spec.add_development_dependency "pry", "~> 0.13.1"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
