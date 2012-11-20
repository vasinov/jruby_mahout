java_import org.apache.mahout.cf.taste.impl.model.file

module JrubyMahout
  class DatamodelBuilder
    attr_writer :file_data_model

    def initialize(file_path)
      @file_data_model = FileDataModel.new(java.io.File.new(file_path))
    end

    def file_data_model=(new_file_path)
      @file_data_model = FileDataModel.new(java.io.File.new(new_file_path))
    end
  end
end

