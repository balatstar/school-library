require './student'
require './teacher'
require './classroom'

class App
  def initialize
    @students = []
    @teachers = []
    @books = []
    @classroom_name = Classroom.new('None')
  end

  def list_books
    puts '[Books]'
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_people
    puts '[Students] '
    @students.each do |student|
      puts "Name: #{student.name}, ID: #{student.id}, Age: #{student.age}"
    end

    puts '[Teachers] '
    @teachers.each do |teacher|
      puts "Name: #{teacher.name}, ID: #{teacher.id}, Age: #{teacher.age}, Specialization: #{teacher.specialization}"
    end
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? Enter the number:'
    person_type = gets.chomp
    
    puts 'Age:'
    age = gets.to_i
    
    puts 'Name:'
    name = gets.chomp
    
    case person_type
    when '1'
      puts 'Has parent permission? (Y/N):'
      parent_permission = gets.chomp.downcase == 'y'
      classroom = @classroom_name
      student = Student.new(age, classroom, name, parent_permission: parent_permission)
      @students << student
      puts 'Person created successfully.'
    when '2'
      puts 'Specialization:'
      specialization = gets.chomp
      teacher = Teacher.new(age, specialization, name)
      @teachers << teacher
      puts 'Person created successfully.'
    else
      puts 'Invalid person type. Please enter "1" for student or "2" for teacher.'
    end
  end

  def create_book
    puts 'Title:'
    title = gets.chomp

    puts 'Author:'
    author = gets.chomp

    book = Book.new(title, author)
    @books << book
    puts "Book created successfully: Title: #{book.title}, Author: #{book.author}"
  end

  def create_rental
    puts 'Select a book from the following list by number:'
    @books.each_with_index do |book, index|
      puts "#{index + 1} - Title: #{book.title}, Author: #{book.author}"
    end

    book_number = gets.to_i

    if book_number < 1 || book_number > @books.length
      puts 'Invalid book selection.'
      return
    end

    selected_book = @books[book_number - 1]

    puts 'Select a person from the following list by number:'

    all_people = @students + @teachers
    all_people.each_with_index do |person, index|
      puts "#{index + 1} - Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end

    person_number = gets.to_i

    if person_number < 1 || person_number > all_people.length
      puts 'Invalid person selection.'
      return
    end

    selected_person = all_people[person_number - 1]

    puts 'Date [use this format: yyyy-mm-dd]:'
    date = gets.chomp

    rental = Rental.new(date, selected_book, selected_person)
    puts "Rental created successfully: Date: #{rental.date}, Book: #{rental.book.title}, Rented by: #{rental.person.name}"
  end

  def list_rentals
    puts 'ID of person:'
    person_id = gets.to_i

    person = (@students + @teachers).find { |p| p.id == person_id }

    if person.nil?
      puts "Person with ID #{person_id} not found."
    else
      puts "Rentals for #{person.name} (ID: #{person.id}):"
      person.rentals.each do |rental|
        puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}"
      end
    end
  end
end
