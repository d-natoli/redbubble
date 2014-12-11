# This is a simple script to pull in a filename argument
# and run the processor. Normally I'd put a shebang at
# the top with the ruby path so that this could be run
# as an exectuable but then I'd have to assume where
# your ruby is installed.

require_relative 'image_data_processor'

filename = ARGV[0]
output_dir = ARGV[1]

if filename.nil? || (filename.respond_to?(:empty?) && filename.empty?)
  puts "Please provide the path of the input file!"
  exit
end

if output_dir.nil? || (output_dir.respond_to?(:empty?) && output_dir.empty?)
  puts "Please provide the directory for the output!"
  exit
end

ImageDataProcessor.run filename, output_dir
