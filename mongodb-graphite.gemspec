# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "mongodb-graphite"
  s.version     = '0.1.0.alpha'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Grégoire Seux"]
  s.email       = ["g.seux@criteo.com"]
  s.homepage    = "https://github.com/kamaradclimber/mongodb-graphite"
  s.summary     = %q{}
  s.description = %q{}
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/{functional,unit}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  #s.require_paths = ["lib"]
  
  s.add_dependency "mongo", ">= 1.5.2"
  s.add_dependency "graphite", ">= 0.2.0"
  #s.add_development_dependency "shoulda", ">= 2.1.1"
end