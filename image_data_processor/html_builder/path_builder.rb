# This module is responsible for generating a filename
# from a make and model.

module ImageDataProcessor
  module HtmlBuilder::PathBuilder

    def self.generate(parent, child = nil)
      raise ArgumentError, "Parent can't be nil!" if parent.nil?

      path_parts = ["output"]
      path_parts << parent.downcase.gsub(" ",  "-")
      path_parts << child.downcase.gsub(" ", "-") unless child.nil?
      File.expand_path "#{path_parts.join("/")}.html"
    end

  end
end
