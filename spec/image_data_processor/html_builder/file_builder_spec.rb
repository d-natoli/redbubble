require 'spec_helper'

RSpec.describe ImageDataProcessor::HtmlBuilder::FileBuilder do

  describe "#build" do
    let(:filename){ "output/canon/powershot.html" }
    let(:title){ "Canon Powershot" }

    let(:navigation) do
      [
        "<ul>",
        "<li>",
        "<a href='index.html'>",
        "Index",
        "</a>",
        "</li>",
        "</ul>"
      ].join
    end

    let(:gallery) do
      [
        "<div id='gallery'>",
        "<img src='http://example.com/powershot.jpg' alt='Canon Powershot'></img>",
        "</div>"
      ].join
    end

    subject do
      described_class.new(
        filename: filename,
        title: title,
        navigation: navigation,
        gallery: gallery
      )
    end

    after :each do
      FileUtils.rm_r 'output/'
    end

    it "builds the file" do
      subject.build

      expect(File.exist?('output/canon/powershot.html')).to be true
    end

    it "adds the title" do
      subject.build

      text = File.read 'output/canon/powershot.html'

      expect(text).
        to_not match /{{ TITLE GOES HERE }}/
      expect(text).
        to match /Canon Powershot/
    end

    it "adds the navigation" do
      subject.build

      text = File.read 'output/canon/powershot.html'

      expect(text).
        to_not match /{{ NAVIGATION GOES HERE }}/
      expect(text).
        to match /<a href='index.html'>/
    end

    it "adds the gallery" do
      subject.build

      text = File.read 'output/canon/powershot.html'

      expect(text).
        to_not match /{{ THUMBNAIL IMAGES GO HERE }}/
      expect(text).
        to match /<div id='gallery'>/
    end
  end

end
