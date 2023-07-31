class Inputs
  def self.user_input
    gets.chomp
  end

  def self.user_input_to_i
    gets.chomp.to_i
  end

  def self.user_permission
    gets.chomp.downcase == 'y'
  end
end
