# Recommenders
java_import org.apache.mahout.cf.taste.eval.RecommenderBuilder
java_import org.apache.mahout.cf.taste.impl.similarity.PearsonCorrelationSimilarity
java_import org.apache.mahout.cf.taste.impl.similarity.EuclideanDistanceSimilarity
java_import org.apache.mahout.cf.taste.impl.similarity.SpearmanCorrelationSimilarity
java_import org.apache.mahout.cf.taste.impl.similarity.LogLikelihoodSimilarity
java_import org.apache.mahout.cf.taste.impl.similarity.TanimotoCoefficientSimilarity
java_import org.apache.mahout.cf.taste.impl.similarity.PearsonCorrelationSimilarity

# Neighborhoods
java_import org.apache.mahout.cf.taste.impl.neighborhood.NearestNUserNeighborhood

# Recommenders
java_import org.apache.mahout.cf.taste.impl.recommender.GenericUserBasedRecommender
java_import org.apache.mahout.cf.taste.impl.recommender.GenericItemBasedRecommender
java_import org.apache.mahout.cf.taste.impl.recommender.slopeone.SlopeOneRecommender

# Weighting
java_import org.apache.mahout.cf.taste.common.Weighting

# Evaluators
java_import org.apache.mahout.cf.taste.impl.eval.AverageAbsoluteDifferenceRecommenderEvaluator

# Data Models
java_import org.apache.mahout.cf.taste.impl.model.jdbc.PostgreSQLJDBCDataModel
java_import org.apache.mahout.cf.taste.impl.model.file.FileDataModel

# Postgres
java_import org.postgresql.jdbc2.optional.PoolingDataSource

# Other
java_import java.io.File