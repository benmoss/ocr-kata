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

  it "tells you when it cannot determine a correction" do
    file = File.open("spec/ambiguous.txt")
    expect(process(file)).to eql("888888888 AMB ['888886888', '888888880', '888888988']")
    file = File.open("spec/ambiguous1.txt")
    expect(process(file)).to eql("555555555 AMB ['555655555', '559555555']")
    file = File.open("spec/ambiguous2.txt")
    expect(process(file)).to eql("666666666 AMB ['666566666', '686666666']")
    file = File.open("spec/ambiguous3.txt")
    expect(process(file)).to eql("999999999 AMB ['899999999', '993999999', '999959999']")
    file = File.open("spec/ambiguous4.txt")
    expect(process(file)).to eql("490067715 AMB ['490067115', '490067719', '490867715']")
  end

  after do
    File.delete("result.txt")
  end
end
