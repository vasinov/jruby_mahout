require 'spec_helper'

describe JrubyMahout do
  describe ".get_recommender_builder" do
    it "should return JrubyMahout::RecommenderBuilder" do
      JrubyMahout.create_recommender("PearsonCorrelationSimilarity", 4, "GenericUserBasedRecommender", false).should
        be_an_instance_of JrubyMahout::RecommenderBuilder
    end
  end
end