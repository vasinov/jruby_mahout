module JrubyMahout
  class PostgresManager
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

    def upsert_record(record, name)
      begin
        @statement.execute("UPDATE #{name} SET user_id=#{record[:user_id]}, item_id=#{record[:item_id]}, rating=#{record[:rating]} WHERE user_id=#{record[:user_id]} AND item_id=#{record[:item_id]};")
        @statement.execute("INSERT INTO #{name} (user_id, item_id, rating) SELECT #{record[:user_id]}, #{record[:item_id]}, #{record[:rating]} WHERE NOT EXISTS (SELECT 1 FROM #{name} WHERE user_id=#{record[:user_id]} AND item_id=#{record[:item_id]});")
      rescue java.sql.SQLException => e
        puts e
      end
    end

    def create_table(name)
      begin
        @statement.executeUpdate("
          CREATE TABLE #{name} (
            user_id BIGINT NOT NULL,
            item_id BIGINT NOT NULL,
            rating int NOT NULL,
            created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY (user_id, item_id)
          );
        ")
        @statement.executeUpdate("CREATE INDEX #{name}_user_id_index ON #{name} (user_id);")
        @statement.executeUpdate("CREATE INDEX #{name}_item_id_index ON #{name} (item_id);")
      rescue java.sql.SQLException => e
        puts e
      end
    end

    def delete_table(name)
      begin
        @statement.executeUpdate("DROP INDEX IF EXISTS #{name}_user_id_index;")
        @statement.executeUpdate("DROP INDEX IF EXISTS #{name}_item_id_index;")
        @statement.executeUpdate("DROP TABLE IF EXISTS #{name};")
      rescue java.sql.SQLException => e
        puts e
      end
    end
  end
end