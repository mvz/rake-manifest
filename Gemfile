# frozen_string_literal: true

source "https://rubygems.org"

group :development, :test do
  gem "rake", "~> 13.0"
  gem "rspec", "~> 3.0"
  gem "simplecov", "~> 1.0.0" if RUBY_VERSION >= "3.2.0"
end

group :development do
  gem "rubocop", "~> 1.72"
  gem "rubocop-packaging", "~> 0.6.0"
  gem "rubocop-performance", "~> 1.24"
  gem "rubocop-rake", "~> 0.7.1"
  gem "rubocop-rspec", "~> 3.5"
end

# Specify your gem's dependencies in rake-manifest.gemspec
gemspec
