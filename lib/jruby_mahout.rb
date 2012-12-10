module JrubyMahout
  require 'java'
  require File.join(ENV["MAHOUT_DIR"], 'mahout-core-0.7.jar')
  require File.join(ENV["MAHOUT_DIR"], 'mahout-integration-0.7.jar')
  require File.join(ENV["MAHOUT_DIR"], 'mahout-math-0.7.jar')
  Dir.glob(File.join(ENV["MAHOUT_DIR"], 'lib/*.jar')).each { |d| require d }
  Dir['./lib/jruby_mahout/*.rb'].each{ |f| require f }
end