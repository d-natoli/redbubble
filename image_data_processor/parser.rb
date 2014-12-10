# This class parses the file using nokogiri, pulls out
# the wanted information, and converts it to a hash
# for easier data access.

require 'nokogiri'

module ImageDataProcessor
  class Parser

    class << self
      def parse(filename)
        parser = new(filename)
        images_xml = parser.read_images_data
        convert_xml_to_hashes images_xml
      end

      private

      def convert_xml_to_hashes(images_xml)
        images_xml.inject([]){ |image_data_hashes, image_xml|
          image_data_hashes << convert_single_image_xml(image_xml)
        }
      end

      def convert_single_image_xml(image_xml)
        {
          id: image_data(image_xml, ".//id"),
          make: image_data(image_xml, ".//make"),
          model: image_data(image_xml, ".//model"),
          thumbnail_url: image_data(image_xml, ".//url[@type='small']")
        }
      end

      def image_data(image_xml, path)
        image_xml.xpath(path).text
      end
    end

    private_class_method :new

    def initialize(filename)
      @filename = filename
    end

    attr_reader :filename

    def read_images_data
      document = nil

      File.open(filename) do |file|
        document = Nokogiri::XML(file)
      end

      document.xpath("//work")
    end

  end
end
