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

  def to_json
    {
      id: id,
      age: age,
      name: name,
      specialization: specialization
    }.to_json
  end
end
