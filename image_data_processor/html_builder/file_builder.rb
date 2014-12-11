# This class is responsible for taking the
# given data, inserting it into the template
# and saving the file.

require 'fileutils'

module ImageDataProcessor
  class HtmlBuilder::FileBuilder

    # TODO: Allow the template path to be specified on input
    TEMPLATE = File.expand_path "docs/output-template.html"
    TITLE_PLACEHOLDER = '{{ TITLE GOES HERE }}'
    NAVIGATION_PLACEHOLDER = '{{ NAVIGATION GOES HERE }}'
    GALLERY_PLACEHOLDER = '{{ THUMBNAIL IMAGES GO HERE }}'

    def initialize(filename:, title:, navigation:, gallery:)
      @title = title
      @navigation = navigation
      @gallery = gallery

      @output_dir, _, @filename = filename.rpartition('/')

      @output_dir ||= ""
    end

    attr_reader :filename, :output_dir, :title, :navigation, :gallery

    def build
      build_output_directory

      document =  File.read(TEMPLATE)

      replace(document, TITLE_PLACEHOLDER, title)
      replace(document, NAVIGATION_PLACEHOLDER, navigation)
      replace(document, GALLERY_PLACEHOLDER, gallery)

      write_document_to_file(document)
    end

    private

    def build_output_directory
      FileUtils::mkdir_p output_dir
    end

    def output_path
      File.expand_path(filename, output_dir)
    end

    def replace(document, placeholder, content)
      document.gsub!(placeholder, content)
    end

    def write_document_to_file(document)
      File.open(output_path, 'w+') do |f|
        f.print(document)
      end
    end

  end
end
