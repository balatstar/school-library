require './app'
require './classroom'
require './student'

$students = []
$teachers = []
$books = []

@classroom_name = Classroom.new('None')

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
    list_books($books)
  when 2
    list_people($students, $teachers)
  when 3
    create_person
  when 4
    create_book
  when 5
    create_rental($books, $students + $teachers)
  when 6
    list_rentals($students + $teachers)
  when 7
    puts 'Thank you for using this app!'
    break
  else
    puts 'Invalid choice. Please enter 1 to 7.'
  end
end
