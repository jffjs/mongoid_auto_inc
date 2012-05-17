# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mongoid_auto_inc/version"

Gem::Specification.new do |s|
  s.name        = "mongoid_auto_inc"
  s.version     = MongoidAutoInc::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jeff Smith"]
  s.email       = ["jffreyjs@gmail.com"]
  s.homepage    = "https://github.com/jffjs/mongoid_auto_inc"
  s.summary     = %q{Adds auto increment capabilities to Mongoid::Document}
  s.description = %q{Adds auto increment capabilities to Mongoid::Document}

  s.rubyforge_project = "mongoid_auto_inc"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.required_ruby_version = '>= 1.8.6'
  s.required_rubygems_version = '>= 1.3.5'
  s.add_bundler_dependencies
end
