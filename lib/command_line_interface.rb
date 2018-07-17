require 'pry'

def welcome
  puts 'Welcome to the Star Wars API!'
end

def get_character_from_user
  puts 'please enter a character'
  character = gets.chomp.downcase
  return character
end

