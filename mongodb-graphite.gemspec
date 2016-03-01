# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "mongodb-graphite"
  s.version     = '1.1.2'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Grégoire Seux"]
  s.email       = ["g.seux@criteo.com"]
  s.homepage    = "https://github.com/kamaradclimber/mongodb-graphite"
  s.summary     = %q(Simple gem to provide graphite with mongodb server stats)
  s.description = %q(This gem retrieves detailed server stats from mongo instances, and pushes the information to graphite)
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- test/{functional,unit}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.license     = 'MIT'
  #s.require_paths = ["lib"]

  s.add_dependency "mongo", "= 2.2.3"
  s.add_dependency "simple-graphite", "= 2.1.0"
  s.add_dependency 'daemons', '= 1.2.3'
end
