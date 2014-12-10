require 'spec_helper'

RSpec.describe ImageDataProcessor::Parser do

  describe ".parse" do
    context "when given a valid file" do
      let(:filename){ 'spec/fixtures/valid.xml' }

      it "reads the file and doesn't raise any errors" do
        expect{
          described_class.parse filename
        }.to_not raise_error
      end

      it "reads the file and returns the data in an array of hashes" do
        data_hashes = described_class.parse filename

        expect(data_hashes).to be_an Array
        expect(data_hashes.count).to eq 14
        expect(data_hashes).to all(be_a Hash)
      end

      it "fills the data hashes correctly" do
        data_hashes = described_class.parse(filename)

        expect(data_hashes.first).to eq({
          id: "31820",
          make: "NIKON CORPORATION",
          model: "NIKON D80",
          thumbnail_url: "http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg"
        })

        expect(data_hashes.last).to eq({
          id: "867035",
          make: "",
          model: "",
          thumbnail_url: "http://ih1.redbubble.net/work.867035.1.flat,135x135,075,f.jpg"
        })
      end
    end

    context "when given an invalid file" do
      let(:filename){ "spec/fixtures/invalid.xml" }

      it "raises an argument error" do
        expect{
          described_class.parse(filename)
        }.to raise_error ArgumentError, "File is invalid!"
      end
    end

    context "when given a file that doesn't exist" do
      let(:filename){ "spec/fixtures/idontexist.xml" }

      it "raises an argument error" do
        expect{
          described_class.parse(filename)
        }.to raise_error ArgumentError, "File doesn't exist!"
      end
    end
  end

end
