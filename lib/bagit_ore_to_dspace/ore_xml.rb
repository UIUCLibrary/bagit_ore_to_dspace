require 'fileutils'
require 'nokogiri'

module BagitOreToDspace
  class OreXml
    attr_reader :document, :aggregation_id, :aggregated_resources, :file

    def initialize(f)
      @file = f
      @document = Nokogiri::XML(f)
      find_aggregation_id
      find_aggregated_resources

    end

    def find_aggregation_id
      id_set=[]
      @document.xpath('//ore:isAggregatedBy').each { |node| id_set << node.content }
      id_set.uniq!
      if id_set.length != 1 then
        raise 'ORE has duplicate ids'
      else
        @aggregation_id = id_set.first.sub('_Aggregation', '')
      end
    end

    def find_aggregated_resources
      @aggregated_resources = []
      @document.xpath('//ore:isAggregatedBy').each do |node|
        @aggregated_resources << node.parent.attribute('about').value
      end
    end
  end
end
