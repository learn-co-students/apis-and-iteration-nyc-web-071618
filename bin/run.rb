#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
character = ""
loop do
    # binding.pry
    character = get_character_from_user
    break if character == "exit"
    show_character_movies(character)
end