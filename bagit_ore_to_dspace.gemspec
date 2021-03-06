# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bagit_ore_to_dspace/version'

Gem::Specification.new do |spec|
  spec.name          = "bagit_ore_to_dspace"
  spec.version       = BagitOreToDspace::VERSION
  spec.authors       = ["Nushrat Jahan Khan"]
  spec.email         = ["njkhan2@illinois.edu"]
  spec.summary       = %q{DSpace packager for bags with ORE}
  spec.homepage      = ""
  spec.license       = ""

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency('rdoc')
  spec.add_development_dependency('aruba')
  # spec.add_development_dependency('rake')
  spec.add_dependency('methadone', '~> 1.8.0')

  spec.add_development_dependency('nokogiri')
  spec.add_development_dependency('bagit')
  # spec.add_dependency('')
end
