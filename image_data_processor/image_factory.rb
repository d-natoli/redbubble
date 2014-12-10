# This module is responsible for taking image data
# hashes and converting them into image models.

module ImageDataProcessor
  module ImageFactory

    class << self
      def build_images(image_data_hashes)
        image_data_hashes.inject([]) do |images, image_data_hash|
          images << build_image(image_data_hash)
        end
      end

      private

      def build_image(image_data_hash)
        Image.new image_data_hash
      end
    end

  end
end
