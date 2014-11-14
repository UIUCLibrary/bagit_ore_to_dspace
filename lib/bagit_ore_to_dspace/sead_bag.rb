require 'nokogiri'

module BagitOreToDspace
  class SeadBag
    attr_accessor :bag_dir, :data_files, :ore_file

    @bag_not_well_formed = false

    def initialize(dir)
      @bag_dir = dir
      @data_files = Dir.entries(File.join(dir, "/data"))
      find_ore_file
    end

    def find_ore_file
      ore_array = Dir.entries(@bag_dir).select {|f| f=~/oaiore\.xml$/}
      if ore_array.length != 1 then
        @bag_not_well_formed = true
        @ore_file = nil
      else
        file = File.new(File.expand_path(File.join(@bag_dir, ore_array[0])))
        @ore_file = OreXml.new(file)
      end
    end
  end
end

