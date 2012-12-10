module JrubyMahout
  class Evaluator
    def initialize(data_model, recommender_builder)
      @data_model = data_model
      @recommender_builder = recommender_builder
      @mahout_evaluator = AverageAbsoluteDifferenceRecommenderEvaluator.new()
    end

    def evaluate(training_percentage, evaluation_percentage)
      if @recommender_builder.recommender_name == "GenericItemBasedRecommender" and !@recommender_builder.item_based_allowed
        nil
      else
        Float(@mahout_evaluator.evaluate(@recommender_builder, nil, @data_model, training_percentage, evaluation_percentage))
      end
    end
  end
end

