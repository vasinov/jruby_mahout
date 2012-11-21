module JrubyMahout
  class RecommenderBuilder
    # public interface RecommenderBuilder
    # Implementations of this inner interface are simple helper classes which create a Recommender to be evaluated based on the given DataModel.
    java_import org.apache.mahout.cf.taste.eval.RecommenderBuilder

    def initialize(similarity_name, neighborhood_size, recommender_name, is_weighted)
      @mahout_similarity = org.apache.mahout.cf.taste.impl.similarity
      @mahout_neighborhood = org.apache.mahout.cf.taste.impl.neighborhood
      @mahout_recommender = org.apache.mahout.cf.taste.impl.recommender
      @mahout_recommender_slopeone = org.apache.mahout.cf.taste.impl.recommender.slopeone
      @weighting = org.apache.mahout.cf.taste.common.Weighting
      @is_weighted = is_weighted
      @neighborhood_size = neighborhood_size
      @similarity_name = similarity_name
      @recommender_name = recommender_name
    end

    # buildRecommender(DataModel dataModel)
    # Builds a Recommender implementation to be evaluated, using the given DataModel.
    def buildRecommender(data_model)
      begin
        if @similarity_name == "PearsonCorrelationSimilarity"
          if @is_weighted
            similarity = @mahout_similarity.PearsonCorrelationSimilarity.new(data_model, @weighting::WEIGHTED)
          else
            similarity = @mahout_similarity.PearsonCorrelationSimilarity.new(data_model)
          end
        elsif @similarity_name == "EuclideanDistanceSimilarity"
          if @is_weighted
            similarity = @mahout_similarity.EuclideanDistanceSimilarity.new(data_model, @weighting::WEIGHTED)
          else
            similarity = @mahout_similarity.EuclideanDistanceSimilarity.new(data_model)
          end
        elsif @similarity_name == "SpearmanCorrelationSimilarity"
          similarity = @mahout_similarity.SpearmanCorrelationSimilarity.new(data_model)
        elsif @similarity_name == "LogLikelihoodSimilarity"
          similarity = @mahout_similarity.LogLikelihoodSimilarity.new(data_model)
        elsif @similarity_name == "TanimotoCoefficientSimilarity"
          similarity = @mahout_similarity.TanimotoCoefficientSimilarity.new(data_model)
        elsif @similarity_name == "GenericItemSimilarity"
          # similarity = @mahout_similarity.GenericItemSimilarity.new(@mahout_similarity.PearsonCorrelationSimilarity.new(data_model), data_model)
          similarity = @mahout_similarity.PearsonCorrelationSimilarity.new(data_model, @weighting::WEIGHTED)
        end

        neighborhood = @mahout_neighborhood.NearestNUserNeighborhood.new(Integer(@neighborhood_size), similarity, data_model)

        if @recommender_name == "GenericUserBasedRecommender" and neighborhood
          recommender = @mahout_recommender.GenericUserBasedRecommender.new(data_model, neighborhood, similarity)
        elsif @recommender_name == "GenericItemBasedRecommender"
          recommender = @mahout_recommender.GenericItemBasedRecommender.new(data_model, similarity)
        elsif @recommender_name == "SlopeOneRecommender"
          recommender = @mahout_recommender_slopeone.SlopeOneRecommender.new(data_model)
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