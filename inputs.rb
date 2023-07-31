class Inputs
    def self.user_input
      return gets.chomp
    end
  
    def self.user_input_to_i
      return gets.chomp.to_i
    end
  
    def self.user_permission
      return gets.chomp.downcase == 'y'
    end
  end