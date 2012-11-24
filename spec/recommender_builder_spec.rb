require 'spec_helper'

describe JrubyMahout do
  describe "Recommender" do
    describe ".new" do
      context "with valid arguments" do
        it "should return an instance of JrubyMahout::Recommender for PearsonCorrelationSimilarity and GenericUserBasedRecommender" do
          JrubyMahout::Recommender.new("PearsonCorrelationSimilarity", 5, "GenericUserBasedRecommender", false).should
          be_an_instance_of JrubyMahout::Recommender
        end

        it "should return an instance of JrubyMahout::Recommender for EuclideanDistanceSimilarity and GenericUserBasedRecommender" do
          JrubyMahout::Recommender.new("EuclideanDistanceSimilarity", 5, "GenericUserBasedRecommender", false).should
          be_an_instance_of JrubyMahout::Recommender
        end

        it "should return an instance of JrubyMahout::Recommender for SpearmanCorrelationSimilarity and GenericUserBasedRecommender" do
          JrubyMahout::Recommender.new("SpearmanCorrelationSimilarity", 5, "GenericUserBasedRecommender", false).should
          be_an_instance_of JrubyMahout::Recommender
        end

        it "should return an instance of JrubyMahout::Recommender for LogLikelihoodSimilarity and GenericUserBasedRecommender" do
          JrubyMahout::Recommender.new("LogLikelihoodSimilarity", 5, "GenericUserBasedRecommender", false).should
          be_an_instance_of JrubyMahout::Recommender
        end

        it "should return an instance of JrubyMahout::Recommender for TanimotoCoefficientSimilarity and GenericUserBasedRecommender" do
          JrubyMahout::Recommender.new("TanimotoCoefficientSimilarity", 5, "GenericUserBasedRecommender", false).should
          be_an_instance_of JrubyMahout::Recommender
        end

        it "should return an instance of JrubyMahout::Recommender for GenericItemSimilarity and GenericUserBasedRecommender" do
          JrubyMahout::Recommender.new("GenericItemSimilarity", 5, "GenericUserBasedRecommender", false).should
          be_an_instance_of JrubyMahout::Recommender
        end

        it "should return an instance of JrubyMahout::Recommender for PearsonCorrelationSimilarity and GenericItemBasedRecommender" do
          JrubyMahout::Recommender.new("PearsonCorrelationSimilarity", nil, "GenericItemBasedRecommender", false).should
          be_an_instance_of JrubyMahout::Recommender
        end

        it "should return an instance of JrubyMahout::Recommender for EuclideanDistanceSimilarity and GenericItemBasedRecommender" do
          JrubyMahout::Recommender.new("EuclideanDistanceSimilarity", nil, "GenericItemBasedRecommender", false).should
          be_an_instance_of JrubyMahout::Recommender
        end

        it "should return an instance of JrubyMahout::Recommender for SpearmanCorrelationSimilarity and GenericItemBasedRecommender" do
          JrubyMahout::Recommender.new("SpearmanCorrelationSimilarity", nil, "GenericItemBasedRecommender", false).should
          be_an_instance_of JrubyMahout::Recommender
        end

        it "should return an instance of JrubyMahout::Recommender for LogLikelihoodSimilarity and GenericItemBasedRecommender" do
          JrubyMahout::Recommender.new("LogLikelihoodSimilarity", nil, "GenericItemBasedRecommender", false).should
          be_an_instance_of JrubyMahout::Recommender
        end

        it "should return an instance of JrubyMahout::Recommender for TanimotoCoefficientSimilarity and GenericItemBasedRecommender" do
          JrubyMahout::Recommender.new("TanimotoCoefficientSimilarity", nil, "GenericItemBasedRecommender", false).should
          be_an_instance_of JrubyMahout::Recommender
        end

        it "should return an instance of JrubyMahout::Recommender for GenericItemSimilarity and GenericItemBasedRecommender" do
          JrubyMahout::Recommender.new("GenericItemSimilarity", nil, "GenericItemBasedRecommender", false).should
          be_an_instance_of JrubyMahout::Recommender
        end

        it "should return an instance of JrubyMahout::Recommender for SlopeOneRecommender" do
          JrubyMahout::Recommender.new(nil, nil, "SlopeOneRecommender", false).should
          be_an_instance_of JrubyMahout::Recommender
        end
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

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end
    end
  end
end