require './app'
require './classroom'
require './student'
require './teacher'

app = App.new

def main(app)
  puts 'Welcome to the School Library App!'

  loop do
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person ID'
    puts '7 - Exit'
    choice = gets.to_i

    case choice
    when 1
      app.list_books
    when 2
      app.list_people
    when 3
      app.create_person
    when 4
      app.create_book
    when 5
      app.create_rental
    when 6
      app.list_rentals
    when 7
      puts 'Thank you for using this app!'
      break
    else
      puts 'Invalid choice. Please enter 1 to 7.'
    end
  end
end

main(app)
