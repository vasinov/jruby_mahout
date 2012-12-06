module JrubyMahout
  class DataModel
    java_import org.apache.mahout.cf.taste.impl.model.file.FileDataModel
    java_import java.io.File

    attr_accessor :data_model

    def initialize(data_model_type, params)
      case data_model_type
        when "file"
          @data_model = FileDataModel.new(File.new(params[:file_path]))
        when "MySQLJDBC"

        when "PostgreSQLJDBC"

        else
          @data_model = nil
      end
    end
  end
end

