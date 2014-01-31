class AccountNumber
  def initialize(readers)
    @readers = readers
  end

  def value
    @readers.map(&:value).join
  end

  def illegible?
    @readers.any?(&:illegible?)
  end

  def valid?
    @readers.reverse.each.with_index.inject(0) { |acc, (reader, i)|
      acc + reader.value * (i + 1)
    } % 11 == 0
  end
end
