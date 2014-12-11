# This class is responsible for building the image
# gallery to be inserted into the HTML template.

module ImageDataProcessor
  class HtmlBuilder::GalleryGenerator

    def initialize(images = [])
      @images = images
    end

    attr_reader :images

    def generate_gallery
      ["<div id='gallery'>"].tap{ |gallery_parts|
        gallery_parts << (images.count > 0 ?
                          build_images :
                          "<p>There are no images to display!</p>")

        gallery_parts << "</div>"
      }.join
    end

    private

    def build_images
      images.inject([]){ |images_parts, image|
        images_parts <<
        "<img src='#{image.thumbnail_url}' alt='#{image.make} #{image.model}'></img>"
      }.join
    end

  end
end
