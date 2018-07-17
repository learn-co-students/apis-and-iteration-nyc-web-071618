def welcome
  puts "Get ready to star war!"
end

def get_character_from_user
  puts "Please enter a character."
  # use gets to capture the user's input. This method should return that input, downcased.
  character = gets.chomp
  return character.downcase
end
