module ContactsParser
  class Formatter

    # Format array of contacts
    def self.contacts(data, options = {})
      # Prepare for status printing
      padSize = data.length.to_s.length

      # Format each contact
      data.map.with_index do |row, index|
        # Print status
        if options[:verbose]
          print "Formatting row #{(index + 1).to_s.rjust(padSize, " ")}/#{data.length}\r#{index == data.length - 1 ? "\n" : ""}"
          $stdout.flush
        end
        
        # Return formatted contact
        contact(row)
      end
    end

    # Format array of contact data
    def self.contact(arr)
      {
        first_name:    arr[0],
        middle_name:   arr[1],
        last_name:     arr[2],
        license:       arr[19],
        last_update:   arr[20],
        addresses:     get_addresses(arr),
        phone_numbers: get_phone_numbers(arr)
      }
    end

    # Get addresses from contact array
    def self.get_addresses(arr)
      [
        { start: 3, end: 7  }, # Address 1 
        { start: 8, end: 12 }  # Address 2
      ].map do |range|
        address(arr[range[:start]..range[:end]]) if arr[range[:start]]
      end .compact
    end

    # Get phone numbers from contact array
    def self.get_phone_numbers(arr)
      [
        { start: 13, end: 14 }, # Phone Number 1
        { start: 15, end: 16 }, # Phone Number 2
        { start: 17, end: 18 }  # Phone Number 3
      ].map do |range|
        phone(arr[range[:start]..range[:end]]) if arr[range[:start]]
      end .compact
    end

    # Format address array as hash
    def self.address(arr)
      {
        line_1: arr[0],
        line_2: arr[1],
        city:   arr[2],
        state:  arr[3],
        zip:    arr[4]
      }
    end

    # Format phone array as hash
    def self.phone(arr)
      {
        number: phone_format(arr[0]),
        type:   arr[1]
      }
    end

    # Formats a phone number as (###) ###-####
    def self.phone_format(number)
      number = number
        .gsub(/\D/, "") # Replace non-digits
        .reverse[..9].reverse # Ignore country codes
      
      # Format with parentheses and hyphen
      "(#{number[0..2]}) #{number[3..5]}-#{number[6..9]}"
    end
  end
end