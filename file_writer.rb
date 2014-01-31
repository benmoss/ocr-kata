class FileWriter
  def initialize(file:, number:)
    @file = file
    @number = number
  end

  def write
    @file.write(@number.value)
    if @number.illegible?
      @file.write(" ILL")
    elsif !@number.valid?
      @file.write(" ERR")
    end
  end
end
