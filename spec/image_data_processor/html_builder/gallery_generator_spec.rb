require 'spec_helper'

RSpec.describe ImageDataProcessor::HtmlBuilder::GalleryGenerator do

  describe "#generate" do
    context "when given no images" do
      subject{ described_class.new([]) }

      it "returns an empty gallery" do
        expect(subject.generate)
          .to eq "<div id='gallery'><p>There are no images to display!</p></div>"
      end
    end

    context "when given images" do
      let(:images) do
        [
          ImageDataProcessor::Image.new(
            id: "111",
            make: "Fuji",
            model: "Finepix",
            thumbnail_url: "http://example.com/fuji.jpg"
          ),
          ImageDataProcessor::Image.new(
            id: "222",
            make: "Nikon",
            model: "D80",
            thumbnail_url: "http://example.com/nikon.jpg"
          ),
          ImageDataProcessor::Image.new(
            id: "333",
            make: "Canon",
            model: "Powershot",
            thumbnail_url: "http://example.com/powershot.jpg"
          )
        ]
      end

      let(:expected_output) do
        [
          "<div id='gallery'>",
          "<img src='http://example.com/fuji.jpg' alt='Fuji Finepix'></img>",
          "<img src='http://example.com/nikon.jpg' alt='Nikon D80'></img>",
          "<img src='http://example.com/powershot.jpg' alt='Canon Powershot'></img>",
          "</div>"
        ].join
      end

      subject{ described_class.new images }

      it "creates the correct gallery" do
        expect(subject.generate).to eq expected_output
      end
    end
  end

end
