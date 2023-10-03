require './person'

class Student < Person
  attr_accessor :classroom

  def initialize(age, classroom, name = 'Unknown', parent_permission = true)
    super(age, name, parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end

# student1 = Student.new(10, "Gryffindor", "Harry Potter", false)
# student2 = Student.new(13, "Gryffindor", "George Weasley", true)
# student3 = Student.new(18, "Gryffindor", "Oliver Wood", false)
#
# puts student1.can_use_services?
# puts student2.can_use_services?
# puts student3.can_use_services?
# puts student1.play_hooky
