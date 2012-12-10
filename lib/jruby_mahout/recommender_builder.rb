module JrubyMahout
  class RecommenderBuilder
    attr_accessor :recommender_name, :item_based_allowed
    # public interface RecommenderBuilder
    # Implementations of this inner interface are simple helper classes which create a Recommender to be evaluated based on the given DataModel.
    def initialize(similarity_name, neighborhood_size, recommender_name, is_weighted)
      @is_weighted = is_weighted
      @neighborhood_size = neighborhood_size
      @similarity_name = similarity_name
      @recommender_name = recommender_name
      @item_based_allowed = (@similarity_name == "SpearmanCorrelationSimilarity") ? false : true
    end

    # buildRecommender(DataModel dataModel)
    # Builds a Recommender implementation to be evaluated, using the given DataModel.
    def buildRecommender(data_model)
      begin
        case @similarity_name
          when "PearsonCorrelationSimilarity"
            similarity = (@is_weighted) ? PearsonCorrelationSimilarity.new(data_model, Weighting::WEIGHTED) : PearsonCorrelationSimilarity.new(data_model)
          when "EuclideanDistanceSimilarity"
            similarity = (@is_weighted) ? EuclideanDistanceSimilarity.new(data_model, Weighting::WEIGHTED) : EuclideanDistanceSimilarity.new(data_model)
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

        unless @neighborhood_size.nil?
          neighborhood = NearestNUserNeighborhood.new(Integer(@neighborhood_size), similarity, data_model)
        end

        case @recommender_name
          when "GenericUserBasedRecommender"
            recommender = GenericUserBasedRecommender.new(data_model, neighborhood, similarity)
          when "GenericItemBasedRecommender"
            recommender = (@item_based_allowed) ? GenericItemBasedRecommender.new(data_model, similarity) : nil
          when "SlopeOneRecommender"
            recommender = SlopeOneRecommender.new(data_model)
          else
            recommender = nil
        end

        recommender
      rescue Exception => e
        return e
      end
    end
  end
end