# This class parses the file using nokogiri and
# calls the hash conversion for easier data access.

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
          image_data_hashes << XmlToHash.to_hash(image_xml)
        }
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

require_relative 'parser/xml_to_hash'
