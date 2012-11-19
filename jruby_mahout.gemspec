$LOAD_PATH << File.expand_path("../lib", __FILE__)
require "jruby_mahout/version"

Gem::Specification.new do |gem|
  gem.name        = "jruby_mahout"
  gem.version     = JrubyMahout::VERSION
  gem.authors     = ["Vasily Vasinov"]
  gem.email       = ["vasinov@me.com"]
  gem.homepage    = "https://github.com/vasinov/jruby_mahout"
  gem.summary     = "Wrapper for the machine learning Mahout library written in JRuby"
  gem.description = ""

  gem.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "README.md"]
  gem.test_files = Dir["spec/**/*"]
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec"
end
