# This module is responsible for generating a filename
# from a make and model.

module ImageDataProcessor
  module HtmlBuilder::PathBuilder

    def self.build(output_dir, parent, child = nil)
      raise ArgumentError, "Output directory can't be nil!" if output_dir.nil?
      raise ArgumentError, "Parent can't be nil!" if parent.nil?

      path_parts = [output_dir]
      path_parts << parent.downcase.gsub(" ",  "-")
      path_parts << child.downcase.gsub(" ", "-") unless child.nil?
      File.expand_path "#{path_parts.join("/")}.html"
    end

  end
end
