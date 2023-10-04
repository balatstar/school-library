# test.rb
require './book'
require './rental'
require './person'

# Create some books
book1 = Book.new("The Wheel of Time", "Robert Jordan")
book2 = Book.new("Cats Eye", "Margaret Atwood")

# Create some persons
person1 = Person.new(39, "Dirk Gently")
person2 = Person.new(32, "Todd Brotzman")

# Create rentals
rental1 = Rental.new("2023-10-01", book1, person1)
rental2 = Rental.new("2023-10-02", book1, person2)
rental3 = Rental.new("2023-10-03", book2, person2)

# Test cases
puts "Books:"
puts "Book 1 title: #{book1.title}, author: #{book1.author}"
puts "Book 2 title: #{book2.title}, author: #{book2.author}"

puts "\nPersons:"
puts "Person 1 name: #{person1.name}"
puts "Person 2 name: #{person2.name}"

puts "\nRentals:"
puts "Rental 1 date: #{rental1.date}, book title: #{rental1.book.title}, person name: #{rental1.person.name}"
puts "Rental 2 date: #{rental2.date}, book title: #{rental2.book.title}, person name: #{rental2.person.name}"
puts "Rental 3 date: #{rental3.date}, book title: #{rental3.book.title}, person name: #{rental3.person.name}"
