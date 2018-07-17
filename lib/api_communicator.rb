require 'rest-client'
require 'json'
require 'pry'
require_relative "../lib/command_line_interface.rb"

$url =  'https://swapi.co/api/people/?page=1'

def get_api_results(character)
    all_char = RestClient.get($url)
    char_hash = JSON.parse(all_char)
    data = char_hash["results"]
    if data.find{ |data| data["name"].downcase.include?(character.downcase)} == nil
      # binding.pry
      if char_hash["next"] != nil  
        $url = char_hash["next"]
        get_api_results(character)
        else
          puts "Sorry this character does not exist!"
          $url = 'https://swapi.co/api/people/?page=1'
          return nil
        end
    else
        # if char_hash["next"] != nil
          char_data = data.find { |data| data["name"].downcase.include?(character.downcase)}
          $url = 'https://swapi.co/api/people/?page=1'
          get_character_movies_from_api(char_data)
        # else
        #   puts "Sorry this character does not exist!"
        #   character = get_character_from_user
        #   show_character_movies(character)
        # end
    end
end

def get_character_movies_from_api(char_data)
  film_urls = char_data["films"]
  film_data = film_urls.collect { |data|
    JSON.parse(RestClient.get(data))
  }
  film_data

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

end

def parse_character_movies(films_hash)
  i = 1
  films_hash.each do |movie|
    puts "#{i}. #{movie["title"]}"
    i+=1

  end
  # some iteration magic and puts out the movies in a nice list

end

def show_character_movies(character)
  films_hash = get_api_results(character)
  #  binding.pry
    if films_hash != nil
      parse_character_movies(films_hash)
    end
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

# get_character_movies_from_api('Luke Skywalker')
