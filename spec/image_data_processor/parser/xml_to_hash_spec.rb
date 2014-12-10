require 'spec_helper'

RSpec.describe ImageDataProcessor::Parser::XmlToHash do

  describe ".to_hash" do
    let(:filename){ 'docs/works.xml' }

    let(:document) do
      File.open(filename) do |file|
        Nokogiri::XML(file)
      end
    end

    it "fills the data hashes correctly" do
      image_xml = document.xpath("//work").first

      expect(described_class.to_hash(image_xml)).to eq({
        id: "31820",
        make: "NIKON CORPORATION",
        model: "NIKON D80",
        thumbnail_url: "http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg"
      })

      image_xml = document.xpath("//work").last

      expect(described_class.to_hash(image_xml)).to eq({
        id: "867035",
        make: "",
        model: "",
        thumbnail_url: "http://ih1.redbubble.net/work.867035.1.flat,135x135,075,f.jpg"
      })
    end
  end

end
