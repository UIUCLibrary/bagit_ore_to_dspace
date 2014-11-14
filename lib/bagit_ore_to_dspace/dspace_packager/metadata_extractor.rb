module Nokogiri
  module XML
    class Node
      def is_nonempty_text_node?
        return self.class.name == "Nokogiri::XML::Text" && self.content.strip != ""
      end
      def is_foaf_name_node?
        return !self.namespace.nil? && self.namespace.prefix == "foaf" && self.name == "name"
      end
    end
  end
end

module BagitOreToDspace
  module DspacePackager
    class MetadataExtractor
      attr_accessor :dc, :ore

      def initialize(ore_document, id)
        @ore = ore_document
        @resource_id = id
        @dc = DspaceDc.new
        transform
      end

      def transform
        desired_fields = YAML.load_file(File.join(__dir__, 'config/fields.yml'))
        desired_fields['fields'].each do |field|

          field[1].each do |qualifier|
            ore.document.xpath("//rdf:Description[@rdf:about=\"#{@resource_id}\" or @rdf:about=\"#{@ore.aggregation_id}\"]//dcterms:#{field[0]}").each() do |node|
              node.children.each do |child_node|
                name = nil
                if child_node.is_foaf_name_node?
                  name = node.xpath('foaf:name')[0].content
                elsif child_node.is_nonempty_text_node?
                  name = child_node.content
                end
                if !name.nil?
                  out_node = DspaceDcNode.new(dc.document, field[0], qualifier)
                  out_node.content = name
                  dc.dc_root << out_node.node
                end
              end
            end
          end
        end
      end
    end
  end
end