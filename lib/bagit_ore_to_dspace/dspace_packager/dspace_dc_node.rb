require 'nokogiri'

module BagitOreToDspace
  module DspacePackager
#
# represents a single qualified dublin core node for the dspace metadata output
#
    class DspaceDcNode
      attr_accessor :element, :qualifier, :node

      def initialize(document, element, qualifier)
        @document, @element, @qualifier = document, element, qualifier
        out_node = Nokogiri::XML::Node.new('dcvalue', document)
        out_node['element']= element
        @element = out_node['element']
        out_node['qualifier']= qualifier
        @qualifier = out_node['qualifier']
        @node = out_node
      end

      def content=(content_string)
        @node.content = content_string
      end

      def content
        @node.content
      end
    end
  end
end