# Rake::Manifest

Rake tasks to generate and check a manifest file

## Installation

Add this gem to your gem's development dependencies by adding this line to your
gem's Gemfile:

```ruby
gem 'rake-manifest'
```

Then execute:

```sh
$ bundle install
```

## Usage

After installation, setting up `rake-manifest` for your project requires a
couple of steps, that need to be done in order.

First, set up the rake tasks by adding something like the following to your `Rakefile`:

```ruby
require "rake/manifest"

# Set up manifest tasks
Rake::Manifest::Task.new do |t|
  # Set patterns for inclusion of files in the manifest. Default is ["**/*"]
  t.patterns = ["{docs,examples,lib}/**/*", "LICENSE.txt", "*.md"]
  # Set the name of the manifest file. Default is "Manifest.txt"
  t.manifest_file = "MyManifest.txt"
end
```

This will create the tasks `manifest:generate` and `manifest:check`.

Next, run `manifest:generate` to create your manifest file, carefully verify
that it contains only the files you want, and check it into source control.

Only after you've done that, update your gemspec to fetch its list of files
from the manifest file:

```ruby
  spec.files = File.read("Manifest.txt").split
```

You can now use the `manifest:check` task to verify that all relevant files in
your repo are also in the manifest. This task will fail if the check fails.

If you have a task for building your gem, you can make it depend on
`manifest:check`. This will avoid building the gem with incorrect contents. For
example, if you're using the Bundler gem tasks, add this to your `Rakefile`:

```ruby
task build: "manifest:check"
```

## What files to include in the manifest

I recommend including files needed runtime, and documentation such as
`README.md`, but leaving out developer infrastructure such as tests or the
`Rakefile`. You don't need to include the gemspec or `Gemfile`, since building
the gem will automatically create and include its own gemspec.

## Development

After checking out the repo, run `bundle` to install dependencies. Then, run
`rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome [on GitHub](https://github.com/mvz/rake-manifest).

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
