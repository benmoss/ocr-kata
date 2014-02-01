require_relative 'account_number'

class AccountNumberCorrector
  def initialize(components)
    self.components = components
  end

  def value
    return result.value if result

    components.each.with_index do |component, i|
      component.possible_corrections.each do |correction|
        new_components = components.dup
        new_components[i] = correction
        attempt = AccountNumber.new(new_components)
        if attempt.legible? && attempt.valid?
          self.result = attempt
          break
        end
      end
    end

    self.result = AccountNumber.new(components) unless result
    result.value
  end

  def errors
    result.errors
  end

  private
  attr_accessor :components, :result
end
