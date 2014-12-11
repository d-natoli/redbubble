require 'spec_helper'

RSpec.describe ImageDataProcessor do

  before :each do
    allow(STDOUT).to receive(:puts)
  end

  after :each do
    FileUtils.rm_r 'output/' if Dir.exists?('output')
  end

  describe ".run" do
    context "when given a valid file" do
      let(:filename){ 'spec/fixtures/valid.xml' }

      it "doesn't raise an error" do
        expect{
          described_class.run filename, "output"
        }.to_not raise_error
      end

      it "generates the correct amount of files" do
        described_class.run filename, "output"

        expect(
          Dir[File.join('output', '**', '*')].count{ |file|
            File.file?(file)
          }
        ).to eq 16
        # 16 is derived from:
        # - 1 index file
        # - 6 make files
        # - 7 model files
        # - 1 unknown make file
        # - 1 unknown model file
      end

      it "generates some of the expected files" do
        described_class.run filename, "output"

        expect(File.exist? 'output/index.html').to be true
        expect(File.exist? 'output/canon.html').to be true
        expect(File.exist? 'output/leica/d-lux-3.html').to be true
      end

      it "generates the correct data" do
        described_class.run filename, "output"

        text = File.read File.expand_path('canon/canon-eos-20d.html', 'output')

        # check title
        expect(text).
          to match /Redbubble - Canon - Canon EOS 20D/

        # check navigation
        expect(text).
          to match /<a href='#{File.expand_path('canon.html', 'output')}'>Canon<\/a>/

        # check thumbnail
        expect(text).
          to match /<img src='http:\/\/ih1.redbubble.net\/work.2041.1.flat,135x135,075,f.jpg' alt='Canon Canon EOS 20D'>/
      end
    end

    context "when given an invalid file" do
      let(:filename){ 'spec/fixtures/invalid.xml' }

      it "doesn't raise an exception" do
        allow(STDOUT).to receive(:puts)

        expect{
          described_class.run filename, "output"
        }.to_not raise_error
      end

      it "prints the correct message when given an invalid file" do
        expect(STDOUT).to receive(:puts).with "File is invalid!"
        described_class.run filename, "output"
      end
    end
  end

end
