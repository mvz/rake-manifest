# frozen_string_literal: true

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
end
