require 'rest-client'
require 'pry'
require 'json'


def get_character_movies_from_api(character)
    all_characters = RestClient.get('http://www.swapi.co/api/people/')
    character_hash = JSON.parse(all_characters)
    movies = character_hash["results"].collect do |name_hash|
    if name_hash["name"].downcase == character
      name_hash['films']
    end
 end
 return movies
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  x = films_hash.compact.flatten
 x.each do |film|
  new_film_hash = RestClient.get(film)
  film_data = JSON.parse(new_film_hash)
  y = film_data["title"]
puts y
end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end



## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
