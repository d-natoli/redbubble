# This module is responsible for taking image data
# hashes and converting them into image models.

module ImageDataProcessor
  module ImageFactory

    class << self
      def build_images(image_data_hashes)
        images = image_data_hashes.inject([]){ |images, image_data_hash|
          images << build_image(image_data_hash)
        }

        print_failed_import_message_if_required(images)

        images.compact
      end

      private

      def build_image(image_data_hash)
        Image.new image_data_hash
      rescue ArgumentError
        nil # used to determine a failed import
      end

      def print_failed_import_message_if_required(images)
        count = images.select(&:nil?).count

        if count > 0
          word = count > 1 ? "images" : "image"
          puts "#{count} #{word} failed to import due to invalid attributes!"
        end
      end

    end

  end
end
