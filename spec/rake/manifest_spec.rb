# frozen_string_literal: true

RSpec.describe Rake::Manifest do
  it "has a version number" do
    expect(Rake::Manifest::VERSION).not_to be_nil
  end
end
