module JrubyMahout
  class DataModel
    attr_accessor :data_model

    def initialize(data_model_type, params)
      case data_model_type
        when "file"
          @data_model = FileDataModel.new(java.io.File.new(params[:file_path]))
        when "mysql"
          # TODO: implement
          @data_model = nil
        when "postgres"
          data_source = create_postgresql_data_source(params)
          @data_model = PostgreSQLJDBCDataModel.new(data_source, params[:table_name], "user_id", "item_id", "rating", "created")
        else
          @data_model = nil
      end
    end

    def create_postgresql_data_source(params)
      data_source = PGPoolingDataSource.new()
      data_source.setUser(params[:username])
      data_source.setPassword(params[:password])
      data_source.setServerName(params[:host])
      data_source.setPortNumber(params[:port])
      data_source.setDatabaseName(params[:db_name])

      data_source
    end
  end
end

