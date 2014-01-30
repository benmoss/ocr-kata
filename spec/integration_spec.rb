require_relative '../processor'

describe "reading scanned account number files" do
  it "converts them into actual account numbers" do
    file = File.open("spec/zeros.txt")
    Processor.new(file).process!("result.txt")
    result = File.open("result.txt")
    expect(result.read.chomp).to eql("000000000")
  end

  it "works for every number" do
    file = File.open("spec/all_numbers.txt")
    Processor.new(file).process!("result.txt")
    result = File.open("result.txt")
    expect(result.read.chomp).to eql("123456789")
  end

  after do
    File.delete("result.txt")
  end
end
