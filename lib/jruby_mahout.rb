require 'java'
require File.join(MAHOUT_DIR, 'mahout-core-0.7.jar')
require File.join(MAHOUT_DIR, 'mahout-integration-0.7.jar')
require File.join(MAHOUT_DIR, 'mahout-math-0.7.jar')
Dir.glob(File.join(MAHOUT_DIR, 'lib/*.jar')).each { |d| require d }

require 'jruby_mahout/database_manager'
require 'jruby_mahout/recommender_builder'

module JrubyMahout
  def self.test
    database_manager = DatabaseManager.new("postgres")
    database_manager.load_database
    puts "machine learning is testing"

    builder = RecommenderBuilder.new("PearsonCorrelationSimilarity", 4, "GenericUserBasedRecommender", false)
  end
end