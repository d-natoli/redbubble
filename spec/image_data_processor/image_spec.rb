require 'spec_helper'

RSpec.describe ImageDataProcessor::Image do

  describe 'attributes' do
    context "when passed full data" do
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

    context "when passed an id and thumbnail" do
      let(:valid_attributes) do
        {
          id: "123",
          make: "",
          model: nil,
          thumbnail_url: "http://example.com/really-awesome-photo"
        }
      end

      it "sets the correct attributes" do
        image = described_class.new valid_attributes

        expect(image.id).to eq "123"
        expect(image.make).to eq "Unknown"
        expect(image.model).to eq "Unknown"
        expect(image.thumbnail_url).to eq "http://example.com/really-awesome-photo"
      end
    end

    context "when passed invalid data" do
      let(:invalid_attributes){ {} }

      it "raises an error" do
        expect{
          described_class.new invalid_attributes
        }.to raise_error ArgumentError, "Image must have an ID and thumbnail url!"
      end
    end
  end

  describe "equality" do
    let(:attributes) do
      {
        id: "123",
        make: "Canon",
        model: "Powershot D50",
        thumbnail_url: "http://example.com/really-awesome-photo"
      }
    end

    let(:image){ ImageDataProcessor::Image.new attributes }

    context "when all attributes have the same values" do
      let(:other){ ImageDataProcessor::Image.new attributes }

      it "is equal" do
        expect(image).to eq other
      end
    end

    context "when any attribute has a different value" do
      let(:other_attributes) do
        attributes.dup.tap{ |other|
          other[:make] = "Nikon"
        }
      end

      let(:other){ ImageDataProcessor::Image.new other_attributes }

      it "is not equal" do
        expect(image).to_not eq other
      end
    end
  end

end
