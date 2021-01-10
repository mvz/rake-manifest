# frozen_string_literal: true

require "tmpdir"

RSpec.describe Rake::Manifest::Task do
  let(:rake) { Rake::Application.new }

  before do
    Rake.application = rake
  end

  it "sets up manifest:generate and manifest:check tasks" do
    expect { described_class.new }
      .to change { rake.tasks.map(&:name) }
      .from([])
      .to ["manifest:check", "manifest:generate"]
  end

  it "has default setting for manifest file" do
    expect(described_class.new.manifest_file).not_to be_nil
  end

  it "has default setting for patterns list" do
    expect(described_class.new.patterns).not_to be_nil
  end

  it "allows setting the generated namespace" do
    described_class.new(:foo)
    expect(rake.tasks.map(&:name))
      .to match_array ["foo:check", "foo:generate"]
  end

  describe "the manifest:generate task" do
    let(:tmpdir) { Dir.mktmpdir }

    before do
      Dir.chdir tmpdir
    end

    after do
      Dir.chdir __dir__
      FileUtils.remove_entry tmpdir
    end

    it "writes to the specified manifest file" do
      described_class.new { |c| c.manifest_file = "MyManifest.txt" }
      rake.invoke_task "manifest:generate"

      aggregate_failures do
        expect(File.exist?("MyManifest.txt")).to be_truthy
        expect(File.exist?("Manifest.txt")).to be_falsy
      end
    end

    it "skips literal file names in the patterns if the files do not exist" do
      described_class.new { |c| c.patterns = ["*.rb", "FOO"] }
      FileUtils.touch "foo.rb"
      rake.invoke_task "manifest:generate"
      manifest = File.read("Manifest.txt")
      expect(manifest).to eq "foo.rb\n"
    end

    it "includes literal file names in the patterns if the files exist" do
      described_class.new { |c| c.patterns = ["*.rb", "FOO"] }
      FileUtils.touch "foo.rb"
      FileUtils.touch "FOO"
      rake.invoke_task "manifest:generate"
      manifest = File.read("Manifest.txt")
      expect(manifest).to eq "foo.rb\nFOO\n"
    end

    it "does not include directories in the manifest when using the default pattern" do
      described_class.new
      Dir.mkdir "foo"
      FileUtils.touch "foo.rb"
      FileUtils.touch "foo/foo.rb"
      rake.invoke_task "manifest:generate"
      manifest = File.read("Manifest.txt")
      expect(manifest).to eq "Manifest.txt\nfoo.rb\nfoo/foo.rb\n"
    end

    it "does not include directories in the manifest even if the pattern includes them" do
      described_class.new { |c| c.patterns = ["*.rb", "foo"] }
      Dir.mkdir "foo"
      FileUtils.touch "foo.rb"
      rake.invoke_task "manifest:generate"
      manifest = File.read("Manifest.txt")
      expect(manifest).to eq "foo.rb\n"
    end
  end

  describe "the manifest:check task" do
    let(:tmpdir) { Dir.mktmpdir }

    before do
      Dir.chdir tmpdir
    end

    after do
      Dir.chdir __dir__
      FileUtils.remove_entry tmpdir
    end

    it "checks using the specified manifest file" do
      FileUtils.touch "foo.rb"
      File.write("MyManifest.txt", "MyManifest.txt\nfoo.rb\n")

      described_class.new { |c| c.manifest_file = "MyManifest.txt" }
      expect { rake.invoke_task "manifest:check" }
        .to output("Manifest check succesful\n").to_stdout
    end

    it "detects when literal file names from the patterns do not exist" do
      FileUtils.touch "foo.rb"
      File.write("Manifest.txt", "foo.rb\nFOO\n")

      described_class.new { |c| c.patterns = ["*.rb", "FOO"] }
      expect { rake.invoke_task "manifest:check" }
        .to raise_error "Manifest check failed, try recreating the manifest"
    end
  end
end
