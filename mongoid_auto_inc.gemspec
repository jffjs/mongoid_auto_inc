# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mongoid_auto_inc/version"

Gem::Specification.new do |s|
  s.name        = "mongoid_auto_inc"
  s.version     = MongoidAutoInc::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jeff Smith"]
  s.email       = ["jffreyjs@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Adds auto increment capabilities to Mongoid::Document}
  s.description = %q{Adds auto increment capabilities to Mongoid::Document}

  s.rubyforge_project = "mongoid_auto_inc"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency %q<rspec>, ['~> 2.0.0.beta.22']
      s.add_dependency %q<mongoid>, ['>= 2.0.0.rc.6']
      s.add_dependency %q<activesupport>, ['>=3.0.0']
    else
      s.add_dependency %q<rspec>, ['~> 2.0.0.beta.22']
      s.add_dependency %q<mongoid>, ['>= 2.0.0.rc.6']
      s.add_dependency %q<activesupport>, ['>= 3.0.0']
    end
  else
    s.add_dependency %q<rspec>, ['~> 2.0.0.beta.22']
    s.add_dependency %q<mongoid>, ['>= 2.0.0.rc.6']
    s.add_dependency %q<activesupport>, ['>= 3.0.0']
  end
end
