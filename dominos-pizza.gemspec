$:.push File.expand_path("../lib", __FILE__)
require "dominos-pizza/version"

Gem::Specification.new do |s|
  s.name        = "dominos-pizza"
  s.version     = DominosPizza::VERSION.dup
  s.authors     = ["Jeff Kereakoglow"]
  s.email       = ["info@alexisdigital.com"]
  s.homepage    = "https://github.com/jkereako/dominos-pizza"
  s.summary     = "CLI for Dominos Pizza"
  s.description = "Find stores in your zip code and browse the menu from your terminal."
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
