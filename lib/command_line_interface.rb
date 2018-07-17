def welcome
  # puts out a welcome message here!
  puts "Welcome to the final stop"
end

def get_character_from_user
  puts "please enter a character"
  input = gets.chomp
  input.downcase!
end
