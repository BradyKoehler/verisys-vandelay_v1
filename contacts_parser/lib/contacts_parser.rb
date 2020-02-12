require "contacts_parser/files"
require "contacts_parser/formatter"
require "contacts_parser/validator"
require "contacts_parser/version"

module ContactsParser
  class Error < StandardError; end

  # Displays usage statistics
  def self.usage
    puts "Usage: contacts_parser <filename> [options...]"
    puts "  -o, --output    Ouput filename"

    exit(1)
  end
  
  class Parse

    # Determines file options based on command line arguments
    def initialize(args = [])
      # Display usage details if no arguments are passed
      ContactsParser.usage if args.length == 0

      # Get the CSV file to read
      @in_file = args[0]

      # Set the output filename
      if args[1] == "-o" && args[2]
        @out_file = args[2]
      else
        @out_file = "#{@in_file}.json"
      end
    end

    # Main function
    def run
      # Get the raw data from the input file
      raw_data = Files::read(@in_file)
      
      # Format the data arrays
      contacts = Formatter::contacts(raw_data[1..])

      # Validate contacts
      contacts, invalid = Validator::contacts(contacts)

      # Print validation results
      puts "#{contacts.length} valid, #{invalid.length} invalid"

      # Write data to file as JSON
      Files::write(@out_file, contacts)
    end
  end
end
