class AccountNumber
  def initialize(components)
    self.components = components
  end

  def value
    components.map(&:value).join
  end

  def has_error?
    !errors.nil?
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
    components.reverse.each.with_index.inject(0) { |acc, (component, i)|
      acc + component.value * (i + 1)
    } % 11 == 0
  end

  def illegible?
    components.any?(&:illegible?)
  end

  def invalid?
    !valid?
  end

  private
  attr_accessor :components
end
