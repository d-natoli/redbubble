# This class is the interface for building the
# HTML pages from the template. It calls the
# required generators, then calls the template
# insertion to add the new HTML into the templates
# before saving the template as a new file.

module ImageDataProcessor
  class HtmlBuilder

    def self.build_pages(images, output_dir)
      builder = new(images, output_dir)
      builder.build_index_page
      builder.build_make_pages
      builder.build_model_pages
    end

    def initialize(images, output_dir)
      @images = images
      @output_dir = output_dir
    end

    attr_reader :images, :output_dir

    def build_index_page
      build_page filename: build_path("index"),
        title: build_title,
        navigation: build_navigation(images, :make),
        gallery: build_gallery(images.take(10))
    end

    def build_make_pages
      images_by_make.each do |make, images|
        build_page filename: build_path(make),
          title: build_title(make),
          navigation: build_navigation(images, :model, true),
          gallery: build_gallery(images)
      end
    end

    def build_model_pages
      images_by_make.each do |make, images|
        images_by_model = images.group_by(&:model)

        images_by_model.each do |model, images|
          build_page filename: build_path(make, model),
            title: build_title(make, model),
            navigation: build_navigation(images, :make, true),
            gallery: build_gallery(images)
        end
      end
    end

    private

    def build_path(make, model = nil)
      PathBuilder.build(output_dir, make, model)
    end

    def images_by_make
      @images_by_make ||= images.group_by(&:make)
    end

    def build_title(make = nil, model = nil)
      TitleGenerator.generate(make: make, model: model)
    end

    def build_navigation(images, type, include_index = false)
      NavigationGenerator.new(
        images: images,
        type: type,
        output_dir: output_dir,
        include_index: include_index
      ).generate
    end

    def build_gallery(images)
      GalleryGenerator.new(images).generate
    end

    def build_page(attributes)
      FileBuilder.new(attributes).build
    end

  end
end

require_relative 'html_builder/title_generator'
require_relative 'html_builder/navigation_generator'
require_relative 'html_builder/gallery_generator'
require_relative 'html_builder/path_builder'
require_relative 'html_builder/file_builder'
