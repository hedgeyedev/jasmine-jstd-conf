# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jasmine-jstd-conf/version"

Gem::Specification.new do |s|
  s.name        = "jasmine-jstd-conf"
  s.version     = Jasmine::JSTD::Conf::VERSION
  s.authors     = ["Benjamin Oakes"]
  s.email       = ["boakes@hedgeye.com"]
  s.homepage    = ""
  s.summary     = %q{Based on jasmine.yml, write a jsTestDriver config file to the supplied path.}
  s.description = s.summary

  s.rubyforge_project = "jasmine-jstd-conf"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('bundler') # For finding jasmine.js
  s.add_dependency('jasmine')
  s.add_dependency('mustache', '~> 0.99.4')

  s.add_development_dependency('bundler', '~> 1.0.0')
  s.add_development_dependency('rake', '~> 0.8.7')
  s.add_development_dependency('rspec', '~> 2.8.0')
  s.add_development_dependency('yard', '< 1.0.0')
end
