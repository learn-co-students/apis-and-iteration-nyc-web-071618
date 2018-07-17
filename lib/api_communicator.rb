require 'rest-client'
require 'json'
require 'pry'

# all_characters = RestClient.get('http://www.swapi.co/api/people/')
#   character_hash = JSON.parse(all_characters)
#   binding.pry

def get_character_movies_from_api(character)
  #make the web request
  all_char = RestClient.get('http://www.swapi.co/api/people/')
  char_hash = JSON.parse(all_char)
  char_data = char_hash["results"].find { |data|
    data["name"].downcase == character.downcase
  }
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
  films_hash.each do |movie|
    i = 1
    puts "#{i}. #{movie["title"]}"
    i+=1

  end
  # some iteration magic and puts out the movies in a nice list

end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

# get_character_movies_from_api('Luke Skywalker')
