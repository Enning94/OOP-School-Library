require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_all_books
    puts 'LIST OF ALL AVAILABLE BOOKS:'
    if @books.empty?
      puts 'No books available'
    else
      @books.each do |book|
        puts "Title: #{book.title}, Author: #{book.author}"
      end
    end
  end

  def list_all_people
    puts 'LIST OF PEOPLE:'
    if @people.empty?
      puts 'No person available'
    else
      @people.each do |person|
        puts " [#{person.class}] Name:#{person.name}, Age:#{person.age}, ID:#{person.id}"
      end
    end
  end

  def create_person
    print 'Do you want to create a Student (1) or a Teacher (2)? [Input the number]:'
    choice = gets.chomp.to_i

    if choice == 1
      create_student
    elsif choice == 2
      create_teacher
    else
      puts 'Invalid choice. Please choose 1 for Student or 2 for Teacher.'
    end
  end

  def create_student
    print 'Name: '
    name = gets.chomp

    print 'Age: '
    age = gets.chomp.to_i

    print 'Has parent permission [Y/N]: '
    parent_permission = gets.chomp

    if parent_permission.downcase == 'n'
      student = Student.new('classroom', name, true, age)
    elsif parent_permission.downcase == 'y'
      student = Student.new('classroom', name, false, age)
    else
      puts 'Invalid Selection'
      return
    end
    @people << student
    puts 'Student Created Successfully'
  end

  def create_teacher
    print 'Name: '
    name = gets.chomp

    print 'Age: '
    age = gets.chomp.to_i

    print 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(specialization, name, true, age)
    @people << teacher
    puts 'Teacher Created Successfully'
  end

  def create_book
    print 'Title: '
    title = gets.chomp

    print 'Author: '
    author = gets.chomp

    book = Book.new(title, author)
    @books << book
    puts 'Book Created Successfully'
  end

  def create_rental
    puts 'Select a book from the following lists'
    @books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }
    book_index = gets.chomp.to_i

    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      puts "#{index}) Name: #{person.name}, AGE: #{person.age}, ID: #{person.id}"
    end
    person_index = gets.chomp.to_i

    print 'Date: '
    date_of_rental = gets.chomp

    rental = Rental.new(date_of_rental, @books[book_index], @people[person_index])
    @rentals << rental
    puts 'Rental created successfully'
  end

  def list_rentals
    print "\nID of the person: "
    person_id = gets.chomp.to_i

    found_rentals = @rentals.select { |rental| rental.person.id == person_id }

    if found_rentals.empty?
      puts "There are currently no rented books in the system under #{person_id} id."
    else
      puts 'Rentals:'
      found_rentals.each do |rental|
        puts "Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}"
      end
    end
  end

  def menu
    puts "\nPlease choose an option by entering a number:"
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - exit'

    puts 'Waiting for your option'
  end

  def display
    options = {
      1 => method(:list_all_books),
      2 => method(:list_all_people),
      3 => method(:create_person),
      4 => method(:create_book),
      5 => method(:create_rental),
      6 => method(:list_rentals),
      7 => method(:exit_app)
    }

    loop do
      menu
      user_option = gets.chomp.to_i

      if options.key?(user_option)
        options[user_option].call
      else
        puts 'Invalid Selection'
      end

      break if user_option == 7
    end
  end

  def exit_app
    puts 'Thank you for using this app!'
  end
end
