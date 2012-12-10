module JrubyMahout
  require 'java'
  require File.join(ENV["MAHOUT_DIR"], 'mahout-core-0.7.jar')
  require File.join(ENV["MAHOUT_DIR"], 'mahout-integration-0.7.jar')
  require File.join(ENV["MAHOUT_DIR"], 'mahout-math-0.7.jar')
  Dir.glob(File.join(ENV["MAHOUT_DIR"], 'lib/*.jar')).each { |d| require d }

  require 'jruby_mahout/recommender'
  require 'jruby_mahout/recommender_builder'
  require 'jruby_mahout/data_model'
  require 'jruby_mahout/evaluator'
  require 'jruby_mahout/postgres_manager'
  require 'jruby_mahout/mysql_manager'
end