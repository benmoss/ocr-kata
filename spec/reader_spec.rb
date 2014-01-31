require_relative '../reader'

describe Reader do
  it "takes a set of characters and converts them into a number" do
    reader = Reader.new([[" _ "],
                         ["| |"],
                         ["|_|"],
                         ["   "]])
    reader.value.should == 0
  end

  it "returns a '?' when gives an unrecognized number" do
    reader = Reader.new(["hi"])
    expect(reader.value).to eql("?")
  end

  it "provides possible corrections for a number" do
    reader = Reader.new([["   "],
                         ["| |"],
                         ["|_|"],
                         ["   "]])
    expect(reader.possible_corrections.map(&:value)).to include(0)
  end
end

