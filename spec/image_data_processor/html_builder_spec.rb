require 'spec_helper'

RSpec.describe ImageDataProcessor::HtmlBuilder do
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

  subject{ described_class.new images }

  after :each do
    FileUtils.rm_r 'output/'
  end

  describe "#build_index_page" do
    it "doesn't throw an error" do
      expect{
        subject.build_index_page
      }.to_not raise_error
    end

    it "calls the generators with the correct values" do
      expect(ImageDataProcessor::HtmlBuilder::NavigationGenerator)
        .to receive(:new).with(images, :make, false).and_call_original
      expect(ImageDataProcessor::HtmlBuilder::GalleryGenerator)
        .to receive(:new).with(images.take 10).and_call_original
      expect(ImageDataProcessor::HtmlBuilder::TitleGenerator)
        .to receive(:generate_title).and_call_original

      subject.build_index_page
    end

    it "calls the filebuilder with the correct values" do
      expect(ImageDataProcessor::HtmlBuilder::FileBuilder).to receive(:new).with(
        filename: File.expand_path("index.html", "output"),
        title: "Redbubble",
        navigation: "<ul><li><a href='#{File.expand_path('fuji.html', 'output')}'>Fuji</a></li><li><a href='#{File.expand_path('nikon.html', 'output')}'>Nikon</a></li><li><a href='#{File.expand_path('canon.html', 'output')}'>Canon</a></li></ul>",
        gallery: "<div id='gallery'><img src='http://example.com/fuji.jpg' alt='Fuji Finepix'></img><img src='http://example.com/nikon.jpg' alt='Nikon D80'></img><img src='http://example.com/powershot.jpg' alt='Canon Powershot'></img></div>"
      ).and_call_original

      subject.build_index_page
    end
  end

  describe "#build_make_pages" do
    it "doesn't throw an error" do
      expect{
        subject.build_make_pages
      }.to_not raise_error
    end

    it "calls the generators with the correct values" do
      allow(ImageDataProcessor::HtmlBuilder::NavigationGenerator)
        .to receive(:new).and_call_original
      allow(ImageDataProcessor::HtmlBuilder::GalleryGenerator)
        .to receive(:new).and_call_original
      allow(ImageDataProcessor::HtmlBuilder::TitleGenerator)
        .to receive(:generate_title).and_call_original

      expect(ImageDataProcessor::HtmlBuilder::NavigationGenerator)
        .to receive(:new).with([images.first], :model, true).and_call_original
      expect(ImageDataProcessor::HtmlBuilder::GalleryGenerator)
        .to receive(:new).with([images.first]).and_call_original
      expect(ImageDataProcessor::HtmlBuilder::TitleGenerator)
        .to receive(:generate_title).and_call_original

      subject.build_make_pages
    end

    it "calls the filebuilder with the correct values" do
      allow(ImageDataProcessor::HtmlBuilder::FileBuilder).to receive(:new).and_call_original

      expect(ImageDataProcessor::HtmlBuilder::FileBuilder).to receive(:new).once.with(
        filename: File.expand_path("fuji.html", "output"),
        title: "Redbubble - Fuji",
        navigation: "<ul><li><a href='#{File.expand_path('index.html', 'output')}'>Index</a></li><li><a href='#{File.expand_path('fuji/finepix.html', 'output')}'>Fuji Finepix</a></li></ul>",
        gallery: "<div id='gallery'><img src='http://example.com/fuji.jpg' alt='Fuji Finepix'></img></div>"
      ).and_call_original

      subject.build_make_pages
    end
  end

  describe "#build_model_pages" do
    it "doesn't throw an error" do
      expect{
        subject.build_model_pages
      }.to_not raise_error
    end

    it "calls the generators with the correct values" do
      allow(ImageDataProcessor::HtmlBuilder::NavigationGenerator)
        .to receive(:new).and_call_original
      allow(ImageDataProcessor::HtmlBuilder::GalleryGenerator)
        .to receive(:new).and_call_original
      allow(ImageDataProcessor::HtmlBuilder::TitleGenerator)
        .to receive(:generate_title).and_call_original

      expect(ImageDataProcessor::HtmlBuilder::NavigationGenerator)
        .to receive(:new).with([images.first], :make, true).and_call_original
      expect(ImageDataProcessor::HtmlBuilder::GalleryGenerator)
        .to receive(:new).with([images.first]).and_call_original
      expect(ImageDataProcessor::HtmlBuilder::TitleGenerator)
        .to receive(:generate_title).and_call_original

      subject.build_model_pages
    end

    it "calls the filebuilder with the correct values" do
      allow(ImageDataProcessor::HtmlBuilder::FileBuilder).to receive(:new).and_call_original

      expect(ImageDataProcessor::HtmlBuilder::FileBuilder).to receive(:new).once.with(
        filename: File.expand_path("fuji/finepix.html", "output"),
        title: "Redbubble - Fuji - Finepix",
        navigation: "<ul><li><a href='#{File.expand_path('index.html', 'output')}'>Index</a></li><li><a href='#{File.expand_path('fuji.html', 'output')}'>Fuji</a></li></ul>",
        gallery: "<div id='gallery'><img src='http://example.com/fuji.jpg' alt='Fuji Finepix'></img></div>"
      ).and_call_original

      subject.build_model_pages
    end
  end

end
