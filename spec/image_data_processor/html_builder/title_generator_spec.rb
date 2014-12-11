require 'spec_helper'

RSpec.describe ImageDataProcessor::HtmlBuilder::TitleGenerator do

  describe ".generate_title" do
    context "when passed no make or model" do
      it "generates the correct title" do
        expect(described_class.generate_title).to eq "Redbubble"
      end
    end

    context "when passed a make but not model" do
      it "generates the correct title" do
        expect(described_class.generate_title(make: "Nikon"))
          .to eq "Redbubble - Nikon"
      end
    end

    context "when passed a model but no make" do
      it "generates the correct title" do
        expect(described_class.generate_title(model: "Powershot"))
          .to eq "Redbubble"
      end
    end

    context "when passed a make and a model" do
      it "generates the correct title" do
        expect(described_class.generate_title(make: "Canon", model: "Powershot"))
          .to eq "Redbubble - Canon - Powershot"
      end
    end
  end

end
