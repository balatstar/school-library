require './person'

class Teacher < Person
  attr_accessor :specialization

  def initialize(age, specialization, name = 'Unknown')
    super(age, name)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end

# teacher1 = Teacher.new(26, "Charms", "Ms Evans")
# teacher2 = Teacher.new(45, "Potions", "Professor Snape")
#
# puts teacher1.can_use_services?
# puts teacher2.name
