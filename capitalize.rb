require './decorator'

class CapitalizeDecorator < Decorator
    def correct_name
      capitalized_name = @nameable.correct_name.capitalize
      return capitalized_name
    end
  end
  