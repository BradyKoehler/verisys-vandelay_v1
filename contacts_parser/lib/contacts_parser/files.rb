require "csv"
require "json"

module ContactsParser
  class Files
    
    # Reads data from a CSV file
    def self.read(filename)
      # TODO: verify that file exists
      # TODO: handle CSV errors
      CSV.read(filename)
    end

    # Writes data to a file as JSON
    def self.write(filename, data)
      File.write(filename, data.to_json)
    end
  end
end