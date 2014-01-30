require_relative 'reader'

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

    File.open(output_path, "w") do |f|
      readers.map(&:value).each.with_index do |value, index|
        f.write(value)
      end
    end
  end
end
