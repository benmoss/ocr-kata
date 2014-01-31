require_relative 'reader'
require_relative 'file_writer'
require_relative 'account_number'

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

    number = AccountNumber.new(readers)

    File.open(output_path, "w") do |f|
      FileWriter.new(file: f, number: number).write
    end
  end
end
