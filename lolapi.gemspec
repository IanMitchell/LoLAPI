lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'LoLAPI/version'

Gem::Specification.new do |spec|
  spec.name          = 'lolapi'
  spec.version       = LoLAPI::VERSION
  spec.authors       = ["Ian Mitchell", "Andy Tsao"]
  spec.email         = ["ian.mitchel1@live.com", "tsao2@hotmail.com"]
  spec.summary       = "A wrapper for the League of Legends API"
  spec.description   = "A wrapper for the League of Legends API desc"
  spec.homepage      = 'http://github.com/ianmitchell/lolapi'
  spec.license       = "MIT"

  spec.files         = ['lib/lolapi.rb', 'lib/configuration.rb', 'lib/LoLAPI/version.rb']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
