module JrubyMahout
  class RecommenderBuilder
    # public interface RecommenderBuilder
    # Implementations of this inner interface are simple helper classes which create a Recommender to be evaluated based on the given DataModel.
    def initialize(similarity_name, neighborhood_size, recommender_name, is_weighted)
      @is_weighted = is_weighted
      @neighborhood_size = neighborhood_size
      @similarity_name = similarity_name
      @recommender_name = recommender_name
    end

    # buildRecommender(DataModel dataModel)
    # Builds a Recommender implementation to be evaluated, using the given DataModel.
    def buildRecommender(data_model)
      begin
        case @similarity_name
          when "PearsonCorrelationSimilarity"
            if @is_weighted
              similarity = PearsonCorrelationSimilarity.new(data_model, Weighting::WEIGHTED)
            else
              similarity = PearsonCorrelationSimilarity.new(data_model)
            end
          when "EuclideanDistanceSimilarity"
            if @is_weighted
              similarity = EuclideanDistanceSimilarity.new(data_model, Weighting::WEIGHTED)
            else
              similarity = EuclideanDistanceSimilarity.new(data_model)
            end
          when "SpearmanCorrelationSimilarity"
            similarity = SpearmanCorrelationSimilarity.new(data_model)
          when "LogLikelihoodSimilarity"
            similarity = LogLikelihoodSimilarity.new(data_model)
          when "TanimotoCoefficientSimilarity"
            similarity = TanimotoCoefficientSimilarity.new(data_model)
          when "GenericItemSimilarity"
            similarity = PearsonCorrelationSimilarity.new(data_model, Weighting::WEIGHTED)
          else
            similarity = nil
        end

        neighborhood = NearestNUserNeighborhood.new(Integer(@neighborhood_size), similarity, data_model)

        case @recommender_name
          when "GenericUserBasedRecommender"
            recommender = GenericUserBasedRecommender.new(data_model, neighborhood, similarity)
          when "GenericItemBasedRecommender"
            recommender = GenericItemBasedRecommender.new(data_model, similarity)
          when "SlopeOneRecommender"
            recommender = SlopeOneRecommender.new(data_model)
          else
            recommender = nil
        end

        recommender
      rescue java.lang.IllegalArgumentException => e
        return e
      end
    end
  end
end