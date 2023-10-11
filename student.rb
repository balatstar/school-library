require './person'
require './classroom'

class Student < Person
  attr_accessor :classroom

  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
    classroom.add_student(self) # Automatically add the student to the classroom list also
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def to_json
    {
      id: id,
      age: age,
      name: name,
      parent_permission: parent_permission,
    }.to_json
  end
end
