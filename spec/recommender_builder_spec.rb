require 'spec_helper'

describe JrubyMahout do
  describe "Recommender" do
    describe ".new" do
      it "should return an instance of JrubyMahout::Recommender" do
        JrubyMahout::Recommender.new("TanimotoCoefficientSimilarity", 5, "GenericUserBasedRecommender", false).should
        be_an_instance_of JrubyMahout::Recommender
      end
    end

    describe "data_model=" do
      it "should load data model" do
        recommender = JrubyMahout::Recommender.new("TanimotoCoefficientSimilarity", 5, "GenericUserBasedRecommender", false)
        recommender.data_model = "spec/recommender_data.csv"

        recommender.data_model.should be_an_instance_of org.apache.mahout.cf.taste.impl.model.file.FileDataModel
      end
    end

    describe ".recommend" do
      it "should return an array" do
        recommender = JrubyMahout::Recommender.new("TanimotoCoefficientSimilarity", 5, "GenericUserBasedRecommender", false)
        recommender.data_model = "spec/recommender_data.csv"

        recommender.recommend(1, 10).should be_an_instance_of Array
      end
    end

    describe ".evaluate" do
      it "should return an integer" do
        recommender = JrubyMahout::Recommender.new("TanimotoCoefficientSimilarity", 5, "GenericUserBasedRecommender", false)
        recommender.data_model = "spec/recommender_data.csv"

        puts "Evaluation: #{recommender.evaluate(0.7, 0.3)}"

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end
    end
  end
end