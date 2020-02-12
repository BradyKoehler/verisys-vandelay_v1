require "contacts_parser/files"
require "contacts_parser/formatter"
require "contacts_parser/validator"
require "contacts_parser/version"
require "contacts_parser/server/app"

module ContactsParser
  class Error < StandardError; end
  
  class Parse

    # Validates and stores arguments
    def initialize(options = {})
      # Abort if no input file is given
      unless options[:input]
        abort "Error: No input file specified"
      end

      @options = options
    end

    # Helpers for logging when verbose mode is enabled
    def v_puts(msg)
      puts msg if @options[:verbose]
    end
    def v_print(msg)
      if @options[:verbose]
        print msg
        $stdout.flush
      end
    end

    # Main function
    def run
      # Get the raw data from the input file
      v_puts "Reading file...\n\n"
      raw_data = Files::read(@options[:input])
      
      # Format the data arrays
      contacts = Formatter::contacts(raw_data[1..], @options)

      # Validate contacts
      contacts, invalid = Validator::contacts(contacts, @options)

      # Print validation results
      v_puts "#{contacts.length} valid, #{invalid.length} invalid"

      # Write data to file as JSON
      v_puts "\nWriting valid contacts to #{@options[:output]}"
      Files::write(@options[:output], contacts)

      # Write invalid data to file as JSON
      if @options[:invalid]
        v_puts "\nWriting invalid contacts to #{@options[:invalid]}"
        Files::write(@options[:invalid], invalid)
      end

      # Display removed records
      v_puts "\nThe following records were removed:"
      invalid.each do |invalid|
        v_puts "\t#{invalid[:license] && invalid[:license].length > 0 ? invalid[:license] : "(Missing) "} - #{invalid[:first_name]} #{invalid[:last_name]}"
      end
    end
  end
end
