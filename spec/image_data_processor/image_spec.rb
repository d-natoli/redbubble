require 'spec_helper'

RSpec.describe ImageDataProcessor::Image do

  describe 'attributes' do
    let(:valid_attributes) do
      {
        id: "123",
        make: "Canon",
        model: "Powershot D50",
        thumbnail_url: "http://example.com/really-awesome-photo"
      }
    end

    it "sets the correct attributes" do
      image = described_class.new valid_attributes

      expect(image.id).to eq "123"
      expect(image.make).to eq "Canon"
      expect(image.model).to eq "Powershot D50"
      expect(image.thumbnail_url).to eq "http://example.com/really-awesome-photo"
    end
  end

end
