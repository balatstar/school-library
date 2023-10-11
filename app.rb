require 'json'
require './student'
require './teacher'
require './classroom'

class App
  def initialize
    @students = []
    @teachers = []
    @books = []
    @classroom_name = Classroom.new('None')
    load_students
    load_teachers
    load_books
    load_rentals
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

    case person_type

    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'Invalid person type. Please enter "1" for student or "2" for teacher.'
    end
  end

  def create_student
    puts 'Age:'
    age = gets.chomp.to_i

    puts 'Name:'
    name = gets.chomp

    puts 'Has parent permission? (Y/N):'
    parent_permission = gets.chomp.downcase == 'y'

    classroom = @classroom_name
    student = Student.new(age, classroom, name, parent_permission: parent_permission)
    @students << student
    puts 'Student created successfully.'
    save_students
  end

  def create_teacher
    puts 'Age:'
    age = gets.chomp.to_i

    puts 'Name:'
    name = gets.chomp

    puts 'Specialization:'
    specialization = gets.chomp

    teacher = Teacher.new(age, specialization, name)
    @teachers << teacher
    puts 'Teacher created successfully.'
    save_teachers
  end

  def create_book
    puts 'Title:'
    title = gets.chomp

    puts 'Author:'
    author = gets.chomp

    book = Book.new(title, author)
    @books << book
    puts "Book created successfully: Title: #{book.title}, Author: #{book.author}"
    save_books
  end

  def create_rental
    puts 'Select a book from the following list by number:'
    selected_book = select_book

    if selected_book.nil?
      puts 'Invalid book selection.'
      return
    end

    puts 'Select a person from the following list by number:'
    selected_person = select_person

    if selected_person.nil?
      puts 'Invalid person selection.'
      return
    end

    puts 'Date [use this format: yyyy-mm-dd]:'
    date = gets.chomp

    create_and_display_rental(date, selected_book, selected_person)
  end

  def select_book
    @books.each_with_index do |book, index|
      puts "#{index + 1} - Title: #{book.title}, Author: #{book.author}"
    end

    book_number = gets.chomp.to_i

    return nil if book_number < 1 || book_number > @books.length

    @books[book_number - 1]
  end

  def select_person
    all_people = @students + @teachers
    all_people.each_with_index do |person, index|
      puts "#{index + 1} - Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end

    person_number = gets.chomp.to_i

    return nil if person_number < 1 || person_number > all_people.length

    all_people[person_number - 1]
  end

  def create_and_display_rental(date, book, person)
    Rental.new(date, book, person)
    puts 'Rental created successfully.'
    save_rentals
  end

  def list_rentals
    puts 'ID of person:'
    person_id = gets.chomp.to_i

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

  def save_books
    File.open('books.json', 'w') do |file|
      @books.each do |book|
        file.puts(book.to_json)
      end
    end
  end

  def save_students
    File.open('students.json', 'w') do |file|
      @students.each do |student|
        file.puts(student.to_json)
      end
    end
  end

  def save_teachers
    File.open('teachers.json', 'w') do |file|
      @teachers.each do |teacher|
        file.puts(teacher.to_json)
      end
    end
  end

  def save_rentals
    File.open('rentals.json', 'w') do |file|
      @students.each do |student|
        student.rentals.each do |rental|
          file.puts(rental.to_json)
        end
      end
  
      @teachers.each do |teacher|
        teacher.rentals.each do |rental|
          file.puts(rental.to_json)
        end
      end
    end
  end

  def load_books
    if File.exist?('books.json')
      File.open('books.json', 'r') do |file|
        file.each do |line|
          book_data = JSON.parse(line)
          book = Book.new(
            book_data['title'],
            book_data['author']
          )
          @books << book
        end
      end
    end
  end

  def load_students
    if File.exist?('students.json')
      File.open('students.json', 'r') do |file|
        file.each do |line|
          student_data = JSON.parse(line)
          student = Student.new(
            student_data['age'],
            @classroom_name,
            student_data['name'],
            parent_permission: student_data['parent_permission']
          )
          student.id = student_data['id']
          @students << student
        end
      end
    end
  end

  def load_teachers
    if File.exist?('teachers.json')
      File.open('teachers.json', 'r') do |file|
        file.each do |line|
          teacher_data = JSON.parse(line)
          teacher = Teacher.new(
            teacher_data['age'],
            teacher_data['specialization'],
            teacher_data['name']
          )
          teacher.id = teacher_data['id']
          @teachers << teacher
        end
      end
    end
  end

  def load_rentals
    if File.exist?('rentals.json')
      File.open('rentals.json', 'r') do |file|
        file.each do |line|
          rental_data = JSON.parse(line)
  
          # Find the person (student or teacher) by ID
          person = (@students + @teachers).find { |p| p.id == rental_data['person_id'] }
  
          # Find the book by title
          book = @books.find { |b| b.title == rental_data['book_title'] }
  
          # If both the person and book are found, create and add the rental
          if person && book
            rental = Rental.new(rental_data['date'], book, person)
            person.rentals << rental
          end
        end
      end
    end
  end

  def exit_app
    save_students
    save_teachers
    save_books
    save_rentals
    puts 'Thank you for using this app!'
    exit
  end
end
