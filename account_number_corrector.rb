require_relative 'account_number'

class AccountNumberCorrector
  def initialize(components)
    self.components = components
    self.original = AccountNumber.new(components)
    self.corrections = []
  end

  def value
    components.each.with_index do |component, i|
      component.possible_corrections.each do |correction|
        new_components = components.dup
        new_components[i] = correction
        attempt = AccountNumber.new(new_components)
        if attempt.legible? && attempt.valid?
          corrections << attempt
        end
      end
    end

    if corrections.length == 1
      corrections.first.value
    else
      original.value
    end
  end

  def errors
    if corrections.length == 0
      original.errors
    elsif corrections.length == 1
      nil
    else
      "AMB [#{corrections.map(&:value).sort.map {|n| "'#{n}'" }.join(", ")}]"
    end
  end

  private
  attr_accessor :components, :corrections, :original
end
