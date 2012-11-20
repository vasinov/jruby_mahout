require 'java'
require File.join(ENV["MAHOUT_DIR"], 'mahout-core-0.7.jar')
require File.join(ENV["MAHOUT_DIR"], 'mahout-integration-0.7.jar')
require File.join(ENV["MAHOUT_DIR"], 'mahout-math-0.7.jar')
Dir.glob(File.join(ENV["MAHOUT_DIR"], 'lib/*.jar')).each { |d| require d }

require 'jruby_mahout/database_manager'
require 'jruby_mahout/recommender_builder'

module JrubyMahout
  def self.test
    database_manager = DatabaseManager.new("postgres")
    database_manager.load_database
    puts "machine learning is testing"
  end

  def self.create_recommender(similarity_name, neighborhood_size, recommender_name, is_weighted)
    recommender_builder = RecommenderBuilder.new(similarity_name,
                                                 neighborhood_size,
                                                 recommender_name,
                                                 is_weighted)
    data_model = DatamodelBuilder.new("")
    recommender_builder.buildRecommender(data_model)
  end
end