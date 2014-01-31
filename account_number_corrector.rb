require_relative 'account_number'

class AccountNumberCorrector
  def initialize(readers)
    @readers = readers
  end

  def corrected
    corrected = @readers
    @readers.each.with_index do |reader, i|
      reader.possible_corrections.each do |correction|
        new_readers = @readers.dup
        new_readers[i] = correction
        attempt = AccountNumber.new(new_readers)
        if attempt.legible? && attempt.valid?
          corrected = new_readers
          break
        end
      end
    end
    corrected
  end
end
