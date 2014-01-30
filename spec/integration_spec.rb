require_relative '../processor'

describe "reading scanned account number files" do
  it "converts them into actual account numbers" do
    file = File.open("spec/sample.txt")
    processor = Processor.new(file)
    processor.process!("result.txt")
    result = File.open("result.txt")
    result.read.chomp.should == "000000000"
  end

  after do
    File.delete("result.txt")
  end
end
