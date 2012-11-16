require 'jruby_mahout/database_manager'

module JrubyMahout
  def self.test
    database_manager = DatabaseManager.new("postgres")
    database_manager.load_database
    puts "machine learning is testing"
  end
end