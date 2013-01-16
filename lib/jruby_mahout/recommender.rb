module JrubyMahout
  class Recommender
    attr_accessor :is_weighted, :neighborhood_size, :similarity_name, :recommender_name, :data_model, :recommender, :redis_cache

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
      @redis_cache = RedisCache.new(nil, false, nil)
    end

    def data_model=(data_model)
      @data_model = data_model
      @recommender = @recommender_builder.build_recommender(@data_model)
    end

    def recommend(user_id, number_of_items, rescorer)
      begin
        cached_recommendations = (@redis_cache.on?) ? @redis_cache.redis.get("#{@redis_cache.prefix}-recommendations-user_id:#{user_id}-number_of_items:#{number_of_items}")
                                                    : nil

        if cached_recommendations
          JSON.parse(cached_recommendations)
        else
          recommendations = @recommender.recommend(user_id, number_of_items, rescorer)
          recommendations_array = []

          recommendations.each do |recommendation|
            recommendations_array << [recommendation.getItemID, recommendation.getValue.round(5)]
          end

          @redis_cache.redis.set("#{@redis_cache.prefix}-recommendations-user_id:#{user_id}-number_of_items:#{number_of_items}", recommendations_array.to_json) unless @redis_cache.off?

          recommendations_array
        end
      rescue Exception => e
        e
      end
    end

    def evaluate(training_percentage, evaluation_percentage)
      begin
        evaluator = Evaluator.new(@data_model, @recommender_builder)
        evaluator.evaluate(training_percentage, evaluation_percentage)
      rescue Exception => e
        e
      end
    end

    def similar_items(item_id, number_of_items, rescorer)
      begin
        cached_similar_items = (@redis_cache.on?) ? @redis_cache.redis.get("#{@redis_cache.prefix}-similar_items-item_id:#{item_id}-number_of_items:#{number_of_items}")
        : nil

        if cached_similar_items
          JSON.parse(cached_similar_items)
        else
          similarities = @recommender.mostSimilarItems(item_id, number_of_items, rescorer)
          similarities_array = []

          similarities.each do |similarity|
            similarities_array << similarity.getItemID
          end

          @redis_cache.redis.set("#{@redis_cache.prefix}-similar_items-item_id:#{item_id}-number_of_items:#{number_of_items}", similarities_array.to_json) unless @redis_cache.off?

          similarities_array
        end

      rescue Exception => e
        e
      end
    end

    def similar_users(user_id, number_of_users, rescorer)
      begin
        cached_similar_users = (@redis_cache.on?) ? @redis_cache.redis.get("#{@redis_cache.prefix}-similar_users-user_id:#{user_id}-number_of_items:#{number_of_items}")
                                                  : nil

        if cached_similar_users
          JSON.parse(cached_similar_users)
        else
          similar_users = to_array(@recommender.mostSimilarUserIDs(user_id, number_of_users, rescorer))

          @redis_cache.redis.set("#{@redis_cache.prefix}-similar_users-user_id:#{user_id}-number_of_items:#{number_of_items}", similar_users.to_json) unless @redis_cache.off?

          similar_users
        end

      rescue Exception => e
        e
      end
    end

    def estimate_preference(user_id, item_id)
      begin
        cached_estimate_preference = (@redis_cache.on?) ? @redis_cache.redis.get("#{@redis_cache.prefix}-estimate_preference-user_id:#{user_id}-item_id:#{item_id}-number_of_items:#{number_of_items}")
        : nil

        if cached_estimate_preference
          JSON.parse(cached_estimate_preference)
        else
          estimate_preference = @recommender.estimatePreference(user_id, item_id)

          @redis_cache.redis.set("#{@redis_cache.prefix}-estimate_preference-user_id:#{user_id}-item_id:#{item_id}-number_of_items:#{number_of_items}", estimate_preference.to_json) unless @redis_cache.off?

          estimate_preference
        end

      rescue Exception => e
        e
      end
    end

    def recommended_because(user_id, item_id, number_of_items)
      begin
        cached_recommended_because = (@redis_cache.on?) ? @redis_cache.redis.get("#{@redis_cache.prefix}-recommended_because-user_id:#{user_id}-item_id:#{item_id}-number_of_items:#{number_of_items}")
        : nil

        if cached_recommended_because
          JSON.parse(cached_recommended_because)
        else
          recommended_because = to_array(@recommender.recommendedBecause(user_id, item_id, number_of_items))

          @redis_cache.redis.set("#{@redis_cache.prefix}-recommended_because-user_id:#{user_id}-item_id:#{item_id}-number_of_items:#{number_of_items}", recommended_because.to_json) unless @redis_cache.off?

          recommended_because
        end


      rescue Exception => e
        e
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