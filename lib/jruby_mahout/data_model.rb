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
          @data_model = PostgresManager.new(params).setup_data_model(params)
        else
          @data_model = nil
      end
    end
  end
end

