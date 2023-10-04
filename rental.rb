require './book'
require './person'

class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    book.rentals << self # Add to the book rentals array
    person.rentals << self # Add to the person rentals array
  end

end
