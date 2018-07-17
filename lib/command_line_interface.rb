def welcome
  # puts out a welcome message here!
  puts "Find out in which installment(s) a Star Wars character appears in!"
end

def get_character_from_user
  puts "Please enter a character"
  # use gets to capture the user's input. This method should return that input, downcased.
  input = gets.chomp.downcase
  input
end
