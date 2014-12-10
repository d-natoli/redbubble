require 'spec_helper'

RSpec.describe ImageDataProcessor::ImageFactory do

  describe ".build_images" do
    context "given valid image data" do
      let(:image_data) do
        [
          {
            id: "123",
            make: "Canon",
            model: "Powershot",
            thumbnail_url: "http://example.com/ilovedolphins.jpg"
          },
          {
            id: "999",
            make: "",
            model: "",
            thumbnail_url: "http://example.com/argghhcobras.png"
          }
        ]
      end

      let(:image_1) do
        ImageDataProcessor::Image.new image_data.first
      end

      let(:image_2) do
        ImageDataProcessor::Image.new image_data.last
      end

      it "builds the right amount of images" do
        images = described_class.build_images image_data

        expect(images.count).to eq 2
        expect(images).to all(be_an ImageDataProcessor::Image)
      end

      it "builds the correct images" do
        images = described_class.build_images image_data

        expect(images.first).to eq image_1
        expect(images.last).to eq image_2
      end
    end

    context "when given invalid data" do
      let(:image_data) do
        [
          {
            id: "123",
            make: "Canon",
            model: "Powershot",
            thumbnail_url: "http://example.com/ilovedolphins.jpg"
          },
          {
            id: nil,
            make: "",
            model: "",
            thumbnail_url: "http://example.com/argghhcobras.png"
          }
        ]
      end

      let(:image) do
        ImageDataProcessor::Image.new image_data.first
      end

      before :each do
        expect(STDOUT).to receive(:puts)
          .with("1 image failed to import due to invalid attributes!")
      end

      it "doesn't raise an error" do
        expect{
          described_class.build_images image_data
        }.to_not raise_error
      end

      it "creates the valid images" do
        images = described_class.build_images image_data

        expect(images.count).to eq 1
        expect(images.first).to be_an ImageDataProcessor::Image
        expect(images.first).to eq image
      end

    end
  end

end
