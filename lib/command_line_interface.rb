def welcome
  # puts out a welcome message here!
  puts "Welcome to this character list"
end

def get_character_from_user
  require 'rest-client'
  require 'json'

  puts "please enter a character"
  gets.chomp.downcase
  # use gets to capture the user's input. This method should return that input, downcased.
end
