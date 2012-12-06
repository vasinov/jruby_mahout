require 'spec_helper'

describe JrubyMahout::Recommender do
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
      recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

      recommender.data_model.should be_an_instance_of org.apache.mahout.cf.taste.impl.model.file.FileDataModel
    end
  end

  describe ".recommend" do
    context "with valid arguments" do
      it "should return an array for PearsonCorrelationSimilarity and GenericUserBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("PearsonCorrelationSimilarity", 5, "GenericUserBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.recommend(1, 10, nil).should be_an_instance_of Array
      end

      it "should return an array for EuclideanDistanceSimilarity and GenericUserBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("EuclideanDistanceSimilarity", 5, "GenericUserBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.recommend(1, 10, nil).should be_an_instance_of Array
      end

      it "should return an array for SpearmanCorrelationSimilarity and GenericUserBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("SpearmanCorrelationSimilarity", 5, "GenericUserBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.recommend(1, 10, nil).should be_an_instance_of Array
      end

      it "should return an array for LogLikelihoodSimilarity and GenericUserBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("LogLikelihoodSimilarity", 5, "GenericUserBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.recommend(1, 10, nil).should be_an_instance_of Array
      end

      it "should return an array for TanimotoCoefficientSimilarity and GenericUserBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("TanimotoCoefficientSimilarity", 5, "GenericUserBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.recommend(1, 10, nil).should be_an_instance_of Array
      end

      it "should return an array for GenericItemSimilarity and GenericUserBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("GenericItemSimilarity", 5, "GenericUserBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.recommend(1, 10, nil).should be_an_instance_of Array
      end

      it "should return an array for PearsonCorrelationSimilarity and GenericItemBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("PearsonCorrelationSimilarity", nil, "GenericItemBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.recommend(1, 10, nil).should be_an_instance_of Array
      end

      it "should return an array for EuclideanDistanceSimilarity and GenericItemBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("EuclideanDistanceSimilarity", nil, "GenericItemBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.recommend(1, 10, nil).should be_an_instance_of Array
      end

      it "should return an array for LogLikelihoodSimilarity and GenericItemBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("LogLikelihoodSimilarity", nil, "GenericItemBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.recommend(1, 10, nil).should be_an_instance_of Array
      end

      it "should return an array for TanimotoCoefficientSimilarity and GenericItemBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("TanimotoCoefficientSimilarity", nil, "GenericItemBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.recommend(1, 10, nil).should be_an_instance_of Array
      end

      it "should return an array for GenericItemSimilarity and GenericItemBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("GenericItemSimilarity", nil, "GenericItemBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.recommend(1, 10, nil).should be_an_instance_of Array
      end

      it "should return an array for SlopeOneRecommender" do
        recommender = JrubyMahout::Recommender.new("nil", nil, "SlopeOneRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.recommend(1, 10, nil).should be_an_instance_of Array
      end
    end

    context "with invalid arguments" do
      it "should return nil for SpearmanCorrelationSimilarity and GenericItemBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("SpearmanCorrelationSimilarity", nil, "GenericItemBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.recommend(1, 10, nil).should be nil
      end
    end
  end

  describe ".evaluate" do
    context "with valid arguments" do
      it "should return a float" do
        recommender = JrubyMahout::Recommender.new("TanimotoCoefficientSimilarity", 5, "GenericUserBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return an array for PearsonCorrelationSimilarity and GenericUserBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("PearsonCorrelationSimilarity", 5, "GenericUserBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for EuclideanDistanceSimilarity and GenericUserBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("EuclideanDistanceSimilarity", 5, "GenericUserBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for SpearmanCorrelationSimilarity and GenericUserBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("SpearmanCorrelationSimilarity", 5, "GenericUserBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for LogLikelihoodSimilarity and GenericUserBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("LogLikelihoodSimilarity", 5, "GenericUserBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for TanimotoCoefficientSimilarity and GenericUserBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("TanimotoCoefficientSimilarity", 5, "GenericUserBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for GenericItemSimilarity and GenericUserBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("GenericItemSimilarity", 5, "GenericUserBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for PearsonCorrelationSimilarity and GenericItemBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("PearsonCorrelationSimilarity", nil, "GenericItemBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for EuclideanDistanceSimilarity and GenericItemBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("EuclideanDistanceSimilarity", nil, "GenericItemBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for LogLikelihoodSimilarity and GenericItemBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("LogLikelihoodSimilarity", nil, "GenericItemBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for TanimotoCoefficientSimilarity and GenericItemBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("TanimotoCoefficientSimilarity", nil, "GenericItemBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for GenericItemSimilarity and GenericItemBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("GenericItemSimilarity", nil, "GenericItemBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for SlopeOneRecommender" do
        recommender = JrubyMahout::Recommender.new("nil", nil, "SlopeOneRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end
    end

    context "with invalid arguments" do
      it "should return nil for SpearmanCorrelationSimilarity and GenericItemBasedRecommender" do
        recommender = JrubyMahout::Recommender.new("SpearmanCorrelationSimilarity", nil, "GenericItemBasedRecommender", false)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be nil
      end
    end
  end
end