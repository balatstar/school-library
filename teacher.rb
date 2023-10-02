require './person.rb'

class Teacher < Person
  attr_accessor :specialization

  def initialize(age, name = "Unknown", specialization)
    super(age, name)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end

# teacher1 = Teacher.new(26, "Ms Evans", "Charms")
# teacher2 = Teacher.new(45, "Professor Snape", "Potions")
#
# puts teacher1.can_use_services?
# puts teacher2.name