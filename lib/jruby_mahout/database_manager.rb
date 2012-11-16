module JrubyMahout
  class DatabaseManager
    def initialize(database)
     @database = database
    end

    def load_database
      puts "#{@database} loaded!"
    end
  end
end