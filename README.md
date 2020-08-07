# Rake::Manifest

Rake tasks to generate and check a manifest file

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rake-manifest'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rake-manifest

## Usage

Add something like the following to your `Rakefile`:

```ruby
Rake::Manifest::Task.new do |t|
  t.patterns = ["{docs,examples,lib}/**/*", "LICENSE.txt"] # Default is ["**/*"]
  t.manifest_file = "MyManifest.txt" # Default is "Manifest.txt"
end
```

This will create the tasks `manifest:generate` and `manifest:check`.

Next, run `manifest:generate` to create your manifest file, and check it into
source control.

To use the manifest file, use something like the following in your gemspec:

```ruby
  spec.files = File.read("Manifest.txt").split
```

You can use `manifest:check` to see if any files are not in the manifest. If
you have a task for building your gem, you can make it depend on
`manifest:check`. This will avoid building the gem with incorrect contents. For
example, if you're using the Bundler gem tasks, add this to your `Rakefile`:

```ruby
task build: "manifest:check"
```

## Development

After checking out the repo, run `bundle` to install dependencies. Then, run
`rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mvz/rake-manifest.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
