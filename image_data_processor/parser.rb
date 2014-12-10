# This class parses the file using nokogiri and
# calls the hash conversion for easier data access.

module ImageDataProcessor
  class Parser

    class << self
      def parse(filename)
        images_xml = new(filename).parse_file
        convert_xml_to_hashes images_xml
      rescue Errno::ENOENT
        raise ArgumentError, "File doesn't exist!"
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

    def parse_file
      images_xml = self.read_images_data

      raise ArgumentError, "File is invalid!" unless images_xml.count > 0

      images_xml
    end

    def read_images_data
      File.open(filename) do |file|
        Nokogiri::XML(file).xpath("//work")
      end
    end

  end
end

require_relative 'parser/xml_to_hash'
