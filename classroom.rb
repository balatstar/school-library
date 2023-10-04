require './student'

class Classroom
  attr_accessor :label
  attr_reader :students

  def initialize(label)
    @label = label
    @students = [] # Array for storing students
  end

  def add_student(student)
    @students << student
    student.classroom = self  # Set the classroom also for student
  end
end
