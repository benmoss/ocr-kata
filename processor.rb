require_relative 'account_number_component'
require_relative 'file_writer'
require_relative 'account_number'
require_relative 'account_number_corrector'

class Processor
  def initialize(scanned_file)
    @scanned_file = scanned_file
  end

  def process!(output_path)
    lines = @scanned_file.read.split("\n")
    number_of_chars = lines.first.length / 3
    components = number_of_chars.times.map { |i|
      AccountNumberComponent.new(lines.map { |line|
        line.chars.drop(i * 3).take(3)
      })
    }

    File.open(output_path, "w") do |f|
      original = AccountNumber.new(components)
      if original.has_error?
        corrected = AccountNumberCorrector.new(components)
        FileWriter.new(file: f, account: corrected).write
      else
        FileWriter.new(file: f, account: original).write
      end
    end
  end
end
