require 'rest-client'
require 'json'
require 'pry'

# make the web request
# iterate over the character hash to find the collection of `films` for the given
#   `character`
# collect those film API urls, make a web request to each URL to get the info
#  for that film
# return value of this method should be collection of info about each film.
#  i.e. an array of hashes in which each hash reps a given film
# this collection will be the argument given to `parse_character_movies`
#  and that method will do some nice presentation stuff: puts out a list
#  of movies by title. play around with puts out other info about a given film.
# some iteration magic and puts out the movies in a nice list

def get_character_movies_from_api(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  star_wars_hash = character_hash["results"].find do |hash|
    hash["name"].downcase == character.downcase
  end
  film_array = []
  star_wars_hash["films"].each do |url|
    single_film = RestClient.get(url)
    film_data = JSON.parse(single_film)
    film_array << film_data
  end
  film_array
end

films_hash = get_character_movies_from_api("Luke Skywalker")

def parse_character_movies(films_hash)
  films_hash.each do |hash|
    puts hash["title"]
  end
end

parse_character_movies(films_hash)


def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

binding.pry
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
