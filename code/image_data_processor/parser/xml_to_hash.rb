# This module pulls the wanted attributes out of
# the document using Nokogiri, and converts the
# image data into a hash for easier property access.

module ImageDataProcessor
  module Parser::XmlToHash

    class << self
      # TODO: Load the paths and attributes from
      # somewhere so its not so inflexible.
      def to_hash(xml)
        {
          id: image_data(xml, ".//id"),
          make: image_data(xml, ".//make"),
          model: image_data(xml, ".//model"),
          thumbnail_url: image_data(xml, ".//url[@type='small']")
        }
      end

      private

      def image_data(image_xml, path)
        image_xml.xpath(path).text
      end
    end

  end
end
