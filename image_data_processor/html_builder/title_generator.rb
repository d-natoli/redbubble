# This module is responsible for building the appropriate
# title to be inserted into the HTML template.

module ImageDataProcessor
  module HtmlBuilder::TitleGenerator

    def self.generate_title(make: nil, model: nil)
      title_parts = ["Redbubble"]
      title_parts << make unless make.nil?
      title_parts << model unless model.nil? || make.nil?

      title_parts.join(" - ")
    end

  end
end
