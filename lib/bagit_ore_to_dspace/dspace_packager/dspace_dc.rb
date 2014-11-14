require 'fileutils'
require 'nokogiri'

module BagitOreToDspace
  module DspacePackager
    class DspaceDc
      attr_accessor :document, :dc_root

      def initialize()
        @document = Nokogiri::XML('<?xml version="1.0" encoding ="utf-8" standalone="no"?>')
        @dc_root = @document.create_element('dublin_core')
        @dc_root['schema']='dc'
        @document << @dc_root
      end
    end
  end
end