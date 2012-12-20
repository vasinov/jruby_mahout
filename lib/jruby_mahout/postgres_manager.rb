module JrubyMahout
  class PostgresManager
    java_import org.apache.mahout.cf.taste.impl.model.jdbc.PostgreSQLJDBCDataModel

    begin
      java_import org.postgresql.ds.PGPoolingDataSource
    rescue Exception => e
      puts e
    end

    attr_accessor :data_model, :data_source, :statement

    def initialize(params)
      @data_source = PGPoolingDataSource.new()
      @data_source.setUser(params[:username])
      @data_source.setPassword(params[:password])
      @data_source.setServerName(params[:host])
      @data_source.setPortNumber(params[:port])
      @data_source.setDatabaseName(params[:db_name])
    end

    def setup_data_model(params)
      begin
        @data_model = PostgreSQLJDBCDataModel.new(@data_source, params[:table_name], "user_id", "item_id", "rating", "created")
      rescue Exception => e
        puts e
      end
    end

    def create_statement
      begin
        connection = @data_source.getConnection()
        @statement = connection.createStatement()
      rescue Exception => e
        puts e
      end
    end

    def close_data_source
      begin
        @data_source.close()
      rescue Exception => e
        puts e
      end
    end

    def upsert_record(table_name, record)
      begin
        @statement.execute("UPDATE #{table_name} SET user_id=#{record[:user_id]}, item_id=#{record[:item_id]}, rating=#{record[:rating]} WHERE user_id=#{record[:user_id]} AND item_id=#{record[:item_id]};")
        @statement.execute("INSERT INTO #{table_name} (user_id, item_id, rating) SELECT #{record[:user_id]}, #{record[:item_id]}, #{record[:rating]} WHERE NOT EXISTS (SELECT 1 FROM #{table_name} WHERE user_id=#{record[:user_id]} AND item_id=#{record[:item_id]});")
      rescue java.sql.SQLException => e
        puts e
      end
    end

    def delete_record(table_name, record)
      begin
        @statement.execute("DELETE FROM #{table_name} WHERE user_id=#{record[:user_id]} AND item_id=#{record[:item_id]};")
      rescue java.sql.SQLException => e
        puts e
      end
    end

    def create_table(table_name)
      begin
        @statement.executeUpdate("
          CREATE TABLE #{table_name} (
            user_id BIGINT NOT NULL,
            item_id BIGINT NOT NULL,
            rating int NOT NULL,
            created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY (user_id, item_id)
          );
        ")
        @statement.executeUpdate("CREATE INDEX #{table_name}_user_id_index ON #{table_name} (user_id);")
        @statement.executeUpdate("CREATE INDEX #{table_name}_item_id_index ON #{table_name} (item_id);")
      rescue java.sql.SQLException => e
        puts e
      end
    end

    def delete_table(table_name)
      begin
        @statement.executeUpdate("DROP INDEX IF EXISTS #{table_name}_user_id_index;")
        @statement.executeUpdate("DROP INDEX IF EXISTS #{table_name}_item_id_index;")
        @statement.executeUpdate("DROP TABLE IF EXISTS #{table_name};")
      rescue java.sql.SQLException => e
        puts e
      end
    end
  end
end