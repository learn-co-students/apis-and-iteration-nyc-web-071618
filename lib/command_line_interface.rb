def welcome
  # puts out a welcome message here!
  puts "Welcome to the Intergalactic Alliance!"
end

def get_character_from_user
  puts "Please enter a character."
  character_name = gets.chomp
  character_name
  # use gets to capture the user's input. This method should return that input, downcased.
end
