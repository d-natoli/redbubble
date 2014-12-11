require 'spec_helper'

RSpec.describe ImageDataProcessor::HtmlBuilder::PathBuilder do

  describe ".build" do
    context "when given a nil parent" do
      it "raises an error" do
        expect{
          described_class.build "output", nil
        }.to raise_error ArgumentError, "Parent can't be nil!"
      end
    end

    context "when given a parent but no child" do
      it "builds the correct path" do
        expect(described_class.build 'output', 'Index')
          .to eql File.expand_path("index.html", "output")
      end
    end

    context "when given a parent and a child" do
      it "builds the correct path" do
        expect(described_class.build "output", "Canon", "EOS 400D DIGITAL")
          .to eq File.expand_path("canon/eos-400d-digital.html", "output")
      end
    end
  end

end
