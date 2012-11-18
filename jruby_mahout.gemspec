$LOAD_PATH << File.expand_path("../lib", __FILE__)
require "jruby_mahout/version"

Gem::Specification.new do |s|
  s.name        = "jruby_mahout"
  s.version     = JrubyMahout::VERSION
  s.authors     = ["Vasily Vasinov"]
  s.email       = ["vasinov@me.com"]
  s.homepage    = "https://github.com/vasinov/jruby_mahout"
  s.summary     = "Wrapper for the machine learning Mahout library written in JRuby"
  s.description = ""

  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_development_dependency "rspec"
end
