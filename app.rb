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
          @teachers << teacher
        end
      end
    end
  end

  def exit_app
    save_students
    save_teachers
    puts 'Thank you for using this app!'
    exit
  end
end
