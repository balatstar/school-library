require './person.rb'

class Student < Person
  attr_accessor :classroom

  def initialize(age, name = "Unknown", parent_permission = true, classroom)
    super(age, name, parent_permission)
    @classroom = classroom
  end

  def play_hooky
    "¯\\(ツ)/¯"
  end
end

# student1 = Student.new(10, "Harry Potter", false, "Gryffindor")
# student2 = Student.new(13, "George Weasley", true, "Gryffindor")
# student3 = Student.new(18, "Oliver Wood", false, "Gryffindor")
#
# puts student1.can_use_services?
# puts student2.can_use_services?
# puts student3.can_use_services?
# puts student1.play_hooky