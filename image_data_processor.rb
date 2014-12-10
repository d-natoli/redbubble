# This module is the external interface to run
# the image data processing. It takes an input
# filename as a string, runs the file parsing,
# and generates the appropriate html files based
# off the provided template.

require 'nokogiri'

module ImageDataProcessor
end

require_relative 'image_data_processor/parser'
require_relative 'image_data_processor/image'
require_relative 'image_data_processor/image_factory'
