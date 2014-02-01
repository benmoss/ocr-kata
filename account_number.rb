require_relative 'account_number_corrector'

class AccountNumber
  def initialize(readers)
    self.readers = readers
  end

  def value
    if illegible? || invalid?
      self.readers = AccountNumberCorrector.new(readers).corrected
    end

    readers.map(&:value).join
  end

  def errors
    if illegible?
      "ILL"
    elsif invalid?
      "ERR"
    end
  end

  def legible?
    !illegible?
  end

  def valid?
    readers.reverse.each.with_index.inject(0) { |acc, (reader, i)|
      acc + reader.value * (i + 1)
    } % 11 == 0
  end

  def illegible?
    readers.any?(&:illegible?)
  end

  def invalid?
    !valid?
  end

  private
  attr_accessor :readers
end
