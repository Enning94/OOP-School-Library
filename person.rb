require_relative 'nameable'
require_relative 'rental'

class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age, :rentals

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  private

  def of_age?
    @age >= 18
  end

  public

  def can_use_services?
    of_age || parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(book, date)
    rental = Rental.new(book, date, self)
    @rentals << rental
  end
end
