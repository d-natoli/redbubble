# This module is the external interface to run
# the image data processing. It takes an input
# filename as a string, runs the file parsing,
# and generates the appropriate html files based
# off the provided template.

module ImageDataProcessor
  def self.run(filename, output_dir)
    data_hashes = Parser.parse filename
    images = ImageFactory.build_images data_hashes

    HtmlBuilder.build_pages(images, output_dir)
  rescue ArgumentError => e
    puts e.message
  end
end

require_relative 'image_data_processor/parser'
require_relative 'image_data_processor/image'
require_relative 'image_data_processor/image_factory'
require_relative 'image_data_processor/html_builder'
