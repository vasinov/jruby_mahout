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
      @data_model = DataModel.new(file_path).file_data_model
      @recommender = @recommender_builder.buildRecommender(@data_model)
    end

    def recommend(user_id, number_of_items, rescorer)
      if @recommender.nil?
        nil
      else
        recommendations_to_array(@recommender.recommend(user_id, number_of_items, rescorer))
      end
    end

    def evaluate(training_percentage, evaluation_percentage)
      evaluator = Evaluator.new(@data_model, @recommender_builder)
      evaluator.evaluate(training_percentage, evaluation_percentage)
    end

    def item_similarities(item_id, number_of_items)
      if @recommender.nil? or @recommender_name == "GenericUserBasedRecommender"
        nil
      else
        @recommender.mostSimilarItems(item_id, amount)
      end
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