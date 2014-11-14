module BagitOreToDspace

  autoload  :VERSION,   'bagit_ore_to_dspace/version'
  autoload  :SeadBag,   'bagit_ore_to_dspace/sead_bag'
  autoload  :OreXml,    'bagit_ore_to_dspace/ore_xml'

  module DspacePackager
    autoload  :Base,              'bagit_ore_to_dspace/dspace_packager'
    autoload  :MetadataExtractor, 'bagit_ore_to_dspace/dspace_packager/metadata_extractor'
    autoload  :DspaceDc,          'bagit_ore_to_dspace/dspace_packager/dspace_dc'
    autoload  :DspaceDcNode,      'bagit_ore_to_dspace/dspace_packager/dspace_dc_node'
    autoload  :DspacePackage,     'bagit_ore_to_dspace/dspace_packager/dspace_package'
  end

  class Base < Object

    attr_accessor :bag_path, :dest_path

    def initialize(args ={})
      self.bag_path = args[:bag_path]
      self.dest_path = args[:dest_path]
    end

    def run
      bag = SeadBag.new(self.bag_path)

      packager = DspacePackager::Base.new(bag.ore_file)

      packages = packager.generate

      packages.each_with_index do |package, i|
        package.serialize(File.join(dest_path, (i+1).to_s), bag.bag_dir)
      end
    end
  end
end
