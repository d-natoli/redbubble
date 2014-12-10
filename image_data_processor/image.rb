# This class is the model representation for
# the image data. It takes a hash and provides
# the data through accessors. It returns "Unknown"
# if the data is empty so that we can categorize
# all photos.

module ImageDataProcessor
  class Image

    def initialize(attrs)
      @id = attrs.fetch :id
      @make = attrs[:make]
      @model = attrs[:model]
      @thumbnail_url = attrs.fetch :thumbnail_url

      validate!
    rescue KeyError, ArgumentError
      raise ArgumentError, "Image must have an ID and thumbnail url!"
    end

    attr_reader :id, :thumbnail_url

    [:make, :model].each do |attr|
      define_method(attr) do
        #TODO: This is a bit nasty but not sure how to avoid the repetition
        instance_variable = self.instance_variable_get("@#{attr}")
        blank?(instance_variable) ? "Unknown" : instance_variable
      end
    end

    def ==(other)
      [:id, :make, :model, :thumbnail_url].all? do |attr|
        self.__send__(attr) == other.__send__(attr)
      end
    end

    private

    def blank?(value)
      value.respond_to?(:empty?) ? !!value.empty? : !value
    end

    def validate!
      raise ArgumentError, "Invalid argument" if blank?(id) || blank?(thumbnail_url)
    end

  end
end
