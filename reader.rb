class Reader
  def initialize(lines)
    @lines = lines
  end

  def value
    secret_decoder[@lines.join]
  end

  private
  def secret_decoder
    {" _ | ||_|   " => 0}
  end
end
