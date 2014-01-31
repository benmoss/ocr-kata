require_relative 'account_number_corrector'

class AccountNumber
  def initialize(readers)
    @readers = readers
  end

  def value
    if illegible? || invalid?
      @readers = AccountNumberCorrector.new(@readers).corrected
    end

    @readers.map(&:value).join
  end

  def illegible?
    @readers.any?(&:illegible?)
  end

  def legible?
    !illegible?
  end

  def valid?
    @readers.reverse.each.with_index.inject(0) { |acc, (reader, i)|
      acc + reader.value * (i + 1)
    } % 11 == 0
  end

  def invalid?
    !valid?
  end
end
