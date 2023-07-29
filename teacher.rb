require_relative 'person'

class Teacher < Person
  attr_reader :specialization

  def initialize(specialization, age, _parent_permission, name = 'Unknown')
    super(name, age, parent_permission: true)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
