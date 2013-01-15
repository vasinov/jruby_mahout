module JrubyMahout
  class Recommender
    attr_accessor :is_weighted, :neighborhood_size, :similarity_name, :recommender_name, :data_model, :recommender

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

    def data_model=(data_model)
      @data_model = data_model
      @recommender = @recommender_builder.build_recommender(@data_model)
    end

    def recommend(user_id, number_of_items, rescorer)
      if @recommender.nil?
        nil
      else
        recommendations = @recommender.recommend(user_id, number_of_items, rescorer)
        recommendations_array = []

        recommendations.each do |recommendation|
          recommendations_array << [recommendation.getItemID, recommendation.getValue.round(5)]
        end

        recommendations_array
      end
    end

    def evaluate(training_percentage, evaluation_percentage)
      evaluator = Evaluator.new(@data_model, @recommender_builder)
      evaluator.evaluate(training_percentage, evaluation_percentage)
    end

    def similar_items(item_id, number_of_items, rescorer)
      if @recommender.nil? or @recommender_name == "GenericUserBasedRecommender"
        nil
      else
        similarities = @recommender.mostSimilarItems(item_id, number_of_items, rescorer)
        similarities_array = []

        similarities.each do |similarity|
          similarities_array << similarity.getItemID
        end

        similarities_array
      end
    end

    def similar_users(user_id, number_of_users, rescorer)
      if @recommender.nil? or @recommender_name == "GenericItemBasedRecommender"
        nil
      else
        to_array(@recommender.mostSimilarUserIDs(user_id, number_of_users, rescorer))
      end
    end

    def estimate_preference(user_id, item_id)
      if @recommender.nil?
        nil
      else
        @recommender.estimatePreference(user_id, item_id)
      end
    end

    def recommended_because(user_id, item_id, number_of_items)
      if @recommender.nil? or @recommender_name == "GenericUserBasedRecommender"
        nil
      else
        to_array(@recommender.recommendedBecause(user_id, item_id, number_of_items))
      end
    end

    private
    def to_array(things)
      things_array = []
      things.each do |thing_id|
        things_array << thing_id
      end

      things_array
    end
  end
end