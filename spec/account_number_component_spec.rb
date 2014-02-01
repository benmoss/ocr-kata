require_relative '../account_number_component'

describe AccountNumberComponent do
  it "takes a set of characters and converts them into a number" do
    component = AccountNumberComponent.new([[" _ "],
                                            ["| |"],
                                            ["|_|"],
                                            ["   "]])
    component.value.should == 0
  end

  it "returns a '?' when gives an unrecognized number" do
    component = AccountNumberComponent.new(["hi"])
    expect(component.value).to eql("?")
  end

  it "provides possible corrections for a number" do
    component = AccountNumberComponent.new([["   "],
                                            ["| |"],
                                            ["|_|"],
                                            ["   "]])
    expect(component.possible_corrections.map(&:value)).to include(0)
  end
end

