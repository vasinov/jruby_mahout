module JrubyMahout
  class Recommender
    attr_accessor :is_weighted, :neighborhood_size, :similarity_name, :recommender_name, :data_model

    def initialize(similarity_name, neighborhood_size, recommender_name, is_weighted)
      @is_weighted = is_weighted
      @neighborhood_size = neighborhood_size
      @similarity_name = similarity_name
      @recommender_name = recommender_name
      @recommender_builder = RecommenderBuilder.new(@similarity_name,
                                                   @neighborhood_size,
                                                   @recommender_name,
                                                   @is_weighted)
      @data_model = nil
      @recommender = nil
    end

    def data_model=(file_path)
      @data_model = DatamodelBuilder.new(file_path).file_data_model
      @recommender = @recommender_builder.buildRecommender(@data_model)
    end

    def recommend(user_id, number_of_items)
      if @recommender.nil?
        nil
      else
        recommendations_to_array(@recommender.recommend(user_id, number_of_items))
      end
    end

    def evaluate(training_percentage, evaluation_percentage)
      evaluator = AverageAbsoluteDifferenceRecommenderEvaluator.new()

      if @data_model.nil? or @recommender_builder.nil?
        mil
      else
        Float(evaluator.evaluate(@recommender_builder, nil, @data_model, 0.7, 0.3))
      end
    end

    def similarities

    end

    private
    def recommendations_to_array(recommendations)
      recommendations_array = []
      recommendations.each do |recommendation|
        recommendations_array << [recommendation.getItemID, recommendation.getValue.round(5)]
      end

      recommendations_array
    end
  end
end