module JrubyMahout
  class DatamodelBuilder
    java_import org.apache.mahout.cf.taste.impl.model.file.FileDataModel
    java_import java.io.File

    attr_accessor :file_data_model

    def initialize(file_path)
      @file_data_model = FileDataModel.new(File.new(file_path))
    end

    def file_data_model=(new_file_path)
      @file_data_model = FileDataModel.new(File.new(new_file_path))
    end
  end
end

