class Person
  attr_accessor :name, :age, :parent_permission
  attr_reader :id

  def initialize(age, name = "Unknown", parent_permission = true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_services?
    if of_age? || parent_permission
      return true
    else
      return false
    end
  end

  private
  def of_age?
    return age >= 18
  end
end
