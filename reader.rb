class Reader
  def initialize(lines)
    @lines = lines
  end

  def value
    SECRET_DECODER_RING.fetch(@lines.join, ILLEGIBLE_VALUE)
  end

  def illegible?
    value == ILLEGIBLE_VALUE
  end

  SECRET_DECODER_RING = {
    " _ "+
    "| |"+
    "|_|"+
    "   " => 0,
    "   "+
    "  |"+
    "  |"+
    "   " => 1,
    " _ "+
    " _|"+
    "|_ "+
    "   " => 2,
    " _ "+
    " _|"+
    " _|"+
    "   " => 3,
    "   "+
    "|_|"+
    "  |"+
    "   " => 4,
    " _ "+
    "|_ "+
    " _|"+
    "   " => 5,
    " _ "+
    "|_ "+
    "|_|"+
    "   " => 6,
    " _ "+
    "  |"+
    "  |"+
    "   " => 7,
    " _ "+
    "|_|"+
    "|_|"+
    "   " => 8,
    " _ "+
    "|_|"+
    " _|"+
    "   " => 9
  }

  ILLEGIBLE_VALUE = "?"
end
