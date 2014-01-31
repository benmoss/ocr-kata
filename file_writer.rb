class FileWriter
  def initialize(path:, readers:)
    @path = path
    @readers = readers
  end

  def write
    File.open(@path, "w") do |f|
      illegible = false
      @readers.each.with_index do |reader, index|
        begin
          f.write(reader.value)
        rescue Reader::IllegibleAccountNumber
          illegible = true
          f.write("?")
        end
      end

      f.write(" ILL") if illegible
    end
  end
end
