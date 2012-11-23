require 'spec_helper'

describe JrubyMahout do
  describe ".initialize_recommender" do
    it "should return JrubyMahout::RecommenderBuilder" do
      JrubyMahout.initialize_recommender("PearsonCorrelationSimilarity", 4, "GenericUserBasedRecommender", false).should
        be_an_instance_of JrubyMahout::RecommenderBuilder
    end
  end

  describe ".build_recommender" do
    it "should return an instance of an AbstractRecommender" do
      recommender_builder = JrubyMahout.initialize_recommender("TanimotoCoefficientSimilarity",
                                                               5,
                                                               "GenericUserBasedRecommender",
                                                               false)

      JrubyMahout.build_recommender(recommender_builder,
                                    "spec/recommender_data.csv").should
        be_an_instance_of org.apache.mahout.cf.taste.impl.recommender.AbstractRecommender
    end
  end

  describe ".recommend" do
    it "should return an array of recommendations" do
      recommender_builder = JrubyMahout.initialize_recommender("TanimotoCoefficientSimilarity",
                                                               5,
                                                               "GenericUserBasedRecommender",
                                                               false)

      recommender = JrubyMahout.build_recommender(recommender_builder,
                                    "spec/recommender_data.csv")

      JrubyMahout.recommend(recommender, 1, 10).should be_an_instance_of Array
    end
  end
end