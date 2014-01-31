require_relative '../processor'

describe "reading scanned account number files" do
  def process(file)
    Processor.new(file).process!("result.txt")
    result = File.open("result.txt")
    result.read.chomp
  end

  it "converts them into actual account numbers" do
    file = File.open("spec/zeros.txt")
    expect(process(file)).to eql("000000000")
  end

  it "works for every number" do
    file = File.open("spec/all_numbers.txt")
    expect(process(file)).to eql("123456789")
  end

  it "handles illegible account numbers" do
    file = File.open("spec/malformed.txt")
    expect(process(file)).to eql("49006771? ILL")
  end

  it "handles invalid account numbers" do
    file = File.open("spec/invalid.txt")
    expect(process(file)).to eql("664371445 ERR")
  end

  it "attempts to repair invalid numbers" do
    file = File.open("spec/repairable_invalid.txt")
    expect(process(file)).to eql("711111111")
  end

  after do
    File.delete("result.txt")
  end
end
