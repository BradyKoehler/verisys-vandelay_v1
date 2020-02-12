RSpec.describe ContactsParser::Validator do
  it "should detect valid license numbers" do
    expect(ContactsParser::Validator::license("1000545443")).to be true
  end

  it "should detect invalid license numbers" do
    expect(ContactsParser::Validator::license("1000545440")).to be false
  end
end
