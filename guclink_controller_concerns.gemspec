$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "guclink_controller_concerns/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "guclink_controller_concerns"
  s.version     = GuclinkControllerConcerns::VERSION
  s.authors     = ["Ahmed H. Ismail"]
  s.email       = ["ahm3d.hisham@gmail.com"]
  s.homepage    = "https://github.com/ah450/guclink_controller_concerns"
  s.summary     = "Common controller concerns for GUCLINK"
  s.description = "Common controller concerns for GUCLINK"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.6"
  s.add_dependency 'rake'
  s.add_dependency 'jwt'

  s.add_development_dependency "sqlite3"
end
