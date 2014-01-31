require_relative '../account_number'

describe AccountNumber do
  it "is valid when it passes the algo" do
    number = AccountNumber.new([
      double(value: 0),
      double(value: 11)
    ])
    expect(number).to be_valid

    number = AccountNumber.new([
      double(value: 1),
      double(value: 9)
    ])
    expect(number).to be_valid
  end

  it "is invalid when it doesn't" do
    number = AccountNumber.new([
      double(value: 6)
    ])

    expect(number).to_not be_valid
  end
end
