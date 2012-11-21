require 'java'
require File.join(ENV["MAHOUT_DIR"], 'mahout-core-0.7.jar')
require File.join(ENV["MAHOUT_DIR"], 'mahout-integration-0.7.jar')
require File.join(ENV["MAHOUT_DIR"], 'mahout-math-0.7.jar')
Dir.glob(File.join(ENV["MAHOUT_DIR"], 'lib/*.jar')).each { |d| require d }

require 'jruby_mahout/database_manager'
require 'jruby_mahout/recommender_builder'
require 'jruby_mahout/data_model_builder'

module JrubyMahout
  def self.test
    database_manager = DatabaseManager.new("postgres")
    database_manager.load_database
    puts "machine learning is testing"
  end

  def self.initialize_recommender(similarity_name, neighborhood_size, recommender_name, is_weighted)
    RecommenderBuilder.new(similarity_name,
                           neighborhood_size,
                           recommender_name,
                           is_weighted)
  end

  def self.build_recommender(recommender_builder, file_path)
    data_model = DatamodelBuilder.new(file_path).file_data_model
    return recommender_builder.buildRecommender(data_model)
  end

  def self.recommend(recommender, user_id, number_of_items)
    recommendations_to_hash(recommender.recommend(user_id, number_of_items))
  end

  def self.recommendations_to_hash(recommendations)
  recommendations_hash = []
  recommendations.each do |e|
    recommendations_hash << { "item_id" => e.getItemID, "value" => e.getValue.round(5) }
  end

  recommendations_hash
  end
end