require_relative '../reader'

describe Reader do
  it "takes a set of characters and converts them into a number" do
    reader = Reader.new([%w(\ _\ ),
                         %w(|\ |),
                         %w(|_|),
                         %w(\ \ \ )])
    reader.value.should == 0
  end

  it "throws an IllegibleAccountNumber when the number is not recognized" do
    reader = Reader.new(["hi"])
    expect { reader.value }.to raise_error Reader::IllegibleAccountNumber
  end
end

