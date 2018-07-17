require_relative '../lib/api_communicator.rb'
require_relative '../lib/command_line_interface.rb'

@x = []

welcome
while @x == [] do
  character = get_character_from_user
  @x = show_character_movies(character)
end
