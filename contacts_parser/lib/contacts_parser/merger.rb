module ContactsParser
  class Merger
    def self.contacts(data, options = {})
      # License to index mapping
      dict = {}

      # Track merges
      merges = {}

      # Prepare for status printing
      padSize = data.length.to_s.length

      # Sort indexes by license
      data.each_with_index do |contact, index|
        # Print status
        if options[:verbose]
          print "Checking for duplicates #{(index + 1).to_s.rjust(padSize, " ")}/#{data.length}\r#{index == data.length - 1 ? "\n" : ""}"
          $stdout.flush
        end

        # Add index to map
        dict[contact[:license]] ||= []
        dict[contact[:license]] << index
      end

      # Extract duplicates
      dict.select! { |_, indices| indices.length > 1 }

      # Count duplicates
      dups = dict.keys.length
      dupsPadSize = dups.to_s.length

      # Resolve duplicates
      dict.each.with_index do |arr, index|
        # Print status
        if options[:verbose]
          print "Resolving duplicates #{(index + 1).to_s.rjust(padSize, " ")}/#{dups}\r#{index == data.length - 1 ? "\n" : ""}"
          $stdout.flush
        end

        # Extract variables
        license, indices = arr

        # Get dates for each index
        dates = indices.map { |index| [index, data[index][:last_update]] }

        # Order latest to oldest
        dates.sort_by! { |date| read_date(date[1]) } .reverse!

        # Store merges
        merges[license] = dates.map { |date| Marshal.load(Marshal.dump(data[date[0]])) }

        # Merge addresses and phone numbers
        dates[1..].each do |other|
          data[dates[0][0]][:addresses].concat(data[other[0]][:addresses])
          data[dates[0][0]][:phone_numbers].concat(data[other[0]][:phone_numbers])

          # Remove duplicates
          data[other[0]] = nil
        end
      end

      # Remove nil records
      data.compact!

      # Print results
      if options[:verbose]
        puts "\nFound #{data.length} unique records"
      end

      # Return merged records and merge log
      [data, merges]
    end

    def self.read_date(datestring)
      if datestring.index("/")
        datestring = datestring.split("/")
        datestring = "20#{datestring[2]}-#{datestring[0].rjust(2, "0")}-#{datestring[1].rjust(2, "0")}"
      end

      Date.strptime(datestring, "%Y-%m-%d")
    end
  end
end