module BagitOreToDspace
  module DspacePackager
    class Base < Object
    
      def initialize(ore)
        @ore = ore
      end
    
      # needs to get filenames from each agregated id and generate metadata
      def generate
        package_array = []
        @ore.aggregated_resources.each do |id|
          package_array << build_single_package(id)
        end
        package_array << process_top_level_aggregation
        return package_array
      end

      def process_top_level_aggregation
        package = build_single_package(@ore.aggregation_id)
        package.content_filenames << File.basename(@ore.file.path)
        package
      end

      def build_single_package(id)
        crosswalk = MetadataExtractor.new(@ore, id)
        metadata = crosswalk.dc
        filenames = get_filenames(id)
        DspacePackage.new(filenames, metadata)
      end

      def get_filenames(id)
        filenames = []
        @ore.document.xpath("//rdf:Description[@rdf:about='"+id+"']/mets:FLocat").each do |node|

         filenames << node.content
        end
        return filenames
      end
    end
  end
end