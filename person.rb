require './nameable'
require './trimmer'
require './capitalize'
require './book'
require './rental'

class Person < Nameable
  attr_accessor :name, :age, :parent_permission, :rentals, :id

  def initialize(age, name = 'Unknown', parent_permission: true, id: nil)
    super()
    @id = id || Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? || parent_permission
  end

  def correct_name
    name
  end

  private

  def of_age?
    age >= 18
  end
end
