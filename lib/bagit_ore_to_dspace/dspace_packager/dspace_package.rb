require 'fileutils'

module BagitOreToDspace
  module DspacePackager
    class DspacePackage
      attr_accessor :content_filenames
      attr_reader :metadata

      def initialize(content_filenames, metadata)
        @content_filenames, @metadata = content_filenames, metadata
      end

      def serialize(output_dir, bag_loc)
        FileUtils.mkdir_p(output_dir)
        mdata_out = File.open(File.join(output_dir, 'dublin_core.xml'), 'w')
        contents_out = File.open(File.join(output_dir, 'contents'), 'w')
        @metadata.document.write_xml_to(mdata_out)
        @content_filenames.each do |filename|
          full_path_to_file = File.join(bag_loc, filename)
          contents_out.puts "#{File.basename(filename)}\tbundle:ORIGINAL"
          FileUtils.cp(full_path_to_file, output_dir)
        end
        copy_license output_dir, File.join(__dir__, 'config/default-license/license.txt')
        contents_out.puts "license.txt\tbundle:LICENSE"
      ensure
        mdata_out.close if mdata_out
        contents_out.close if contents_out
      end

      def copy_license(output_dir, license = 'config/default-license/license.txt')
        FileUtils.cp license, output_dir
      end
    end
  end
end