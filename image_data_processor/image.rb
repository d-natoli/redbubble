# This class is the model representation for
# the image data. It takes a hash and provides
# the data through accessors. It returns "Unknown"
# if the data is empty so that we can categorize
# all photos.

module ImageDataProcessor
  class Image

    def initialize(attrs)
      @id = attrs[:id]
      @make = attrs[:make]
      @model = attrs[:model]
      @thumbnail_url = attrs[:thumbnail_url]
    end

    attr_reader :id, :thumbnail_url

    [:make, :model].each do |attr|
      define_method(attr) do
        #TODO: This is a bit nasty but not sure how to avoid the repetition
        instance_variable = self.instance_variable_get("@#{attr}")
        blank?(instance_variable) ? "Unknown" : instance_variable
      end
    end

    private

    def blank?(value)
      value.respond_to?(:empty?) ? !!value.empty? : !value
    end

  end
end
