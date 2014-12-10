# This class is the model representation for
# the image data. It takes a hash and provides
# the data through accessors.

module ImageDataProcessor
  class Image

    def initialize(attrs)
      @id = attrs[:id]
      @make = attrs[:make]
      @model = attrs[:model]
      @thumbnail_url = attrs[:thumbnail_url]
    end

    attr_reader :id, :thumbnail_url, :make, :model

  end
end
