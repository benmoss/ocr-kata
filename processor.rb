require_relative 'reader'
require_relative 'file_writer'

class Processor
  def initialize(scanned_file)
    @scanned_file = scanned_file
  end

  def process!(output_path)
    lines = @scanned_file.read.split("\n")
    number_of_chars = lines.first.length / 3
    readers = number_of_chars.times.map { |i|
      Reader.new(lines.map { |line|
        line.chars.drop(i * 3).take(3)
      })
    }

    writer = FileWriter.new(path: output_path, readers: readers)
    writer.write
  end
end
