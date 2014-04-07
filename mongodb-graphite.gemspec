# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "mongodb-graphite"
  s.version     = '1.1.0'
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

  s.add_dependency "mongo", ">= 1.8.0"
  s.add_dependency "simple-graphite", ">= 2.1.0"
  s.add_dependency 'daemons'
end
