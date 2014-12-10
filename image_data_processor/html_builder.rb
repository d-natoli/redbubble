# This class is the interface for building the
# HTML pages from the template. It calls the
# required generators, then calls the template
# insertion to add the new HTML into the templates
# before saving the template as a new file.

module ImageDataProcessor
  module HtmlBuilder

  end
end

require_relative 'html_builder/title_generator'
require_relative 'html_builder/navigation_generator'
