require_relative 'person'
class Student < Person
  attr_reader :classroom

  def initialize(classroom, name = 'Unknown', age = nil, parent_permission: true)
    super(name, age, parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students << self unless classroom.students.include?(self)
  end
end
