require './decorator'

class TrimmerDecorator < Decorator
  def correct_name
    trimmed_name = @nameable.correct_name[0, 10]
    trimmed_name
  end
end
