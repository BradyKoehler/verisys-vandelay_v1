RSpec.describe ContactsParser::Formatter do
  it "should correctly format a contact data array" do
    data = [
      "Jeraldine", # First name
      "Mueller",   # Middle name
      "Cronin",    # Last name

      # Address 1
      "1740 Goodwin Vista", # Line 1
      "Apt. 438",           # Line 2
      "Reynaldofurt",       # City
      "KS",                 # State
      "66277-4472",         # Zip

      # Address 2
      "59659 Manual Corners", # Line 1
      "Suite 523",            # Line 2
      "Clarenceview",         # City
      "HI",                   # State
      "43319",                # Zip

      # Phone 1
      "595.802.0435", # Number
      "Business",     # Type

      # Phone 2
      nil,            # Number
      nil,            # Type

      # Phone 3
      "1-109-818-2429", # Number
      "Business",       # Type

      "7068085734", # License number
      "12/10/17"    # Last updated
    ]
    
    result = [{
      :first_name=>"Jeraldine", 
      :middle_name=>"Mueller", 
      :last_name=>"Cronin", 
      :license=>"7068085734", 
      :last_update=>"12/10/17", 
      :addresses=>[
        {
          :line_1=>"1740 Goodwin Vista", 
          :line_2=>"Apt. 438", 
          :city=>"Reynaldofurt", 
          :state=>"KS", 
          :zip=>"66277-4472"
        }, 
        {
          :line_1=>"59659 Manual Corners", 
          :line_2=>"Suite 523", 
          :city=>"Clarenceview", 
          :state=>"HI", 
          :zip=>"43319"
        }
      ], 
      :phone_numbers=>[
        {:number=>"(595) 802-0435", :type=>"Business"}, 
        {:number=>"(109) 818-2429", :type=>"Business"}
      ]
    }]

    expect(ContactsParser::Formatter::contacts([data])).to eq(result)
  end
end
