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
  end
end
