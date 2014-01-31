require_relative '../reader'

describe Reader do
  it "takes a set of characters and converts them into a number" do
    reader = Reader.new([%w(\ _\ ),
                         %w(|\ |),
                         %w(|_|),
                         %w(\ \ \ )])
    reader.value.should == 0
  end

  it "returns a '?' when gives an unrecognized number" do
    reader = Reader.new(["hi"])
    expect(reader.value).to eql("?")
  end
end

