#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
loop do
  character = get_character_from_user
  if character == ""
    break
  end
  show_character_movies(character)
end
