module ContactsParser
  class Formatter

    # Format array of contacts
    def self.contacts(data)
      data.map { |row| contact(row) }
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
        number: arr[0],
        type:   arr[1]
      }
    end
  end
end