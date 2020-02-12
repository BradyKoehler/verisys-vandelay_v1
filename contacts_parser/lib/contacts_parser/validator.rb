module ContactsParser
  class Validator

    # Validates an array of contacts
    def self.contacts(data, options = {})
      # Hold invalid contacts
      invalid = []

      # Prepare for status printing
      padSize = data.length.to_s.length

      # Use a lambda to utilize "return"
      lambda = ->(contact, index) {
        # Print status
        if options[:verbose]
          print "Validating row #{(index + 1).to_s.rjust(padSize, " ")}/#{data.length}\r#{index == data.length - 1 ? "\n" : ""}"
          $stdout.flush
        end

        # Must have a valid license number
        unless license(contact[:license])
          invalid << contact
          return nil
        end

        return contact
      }

      [data.map.with_index(&lambda).compact, invalid]
    end

    # Validates a license number
    def self.license(number)
      # Must be present and have ten digits
      return false unless number && number.length == 10

      # Must have correct check digit
      return check_digit(number)
    end

    # Validates a license check digit
    def self.check_digit(number)
      number[0..8].split("").reduce(0) { |sum, n| sum + n.to_i } % 10 == number[9].to_i
    end
  end
end