require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
       #make the web request
      all_characters = RestClient.get('http://www.swapi.co/api/people/')
       character_hash = JSON.parse(all_characters)

      char_data = character_hash["results"].find do |char_info|
# the var char_data will equal our parsed data we took from the url will now be look for key "results" and within those values will find
        char_info["name"].downcase == character.downcase
        # if the element we named char_info has a key named "name" and if the value eqauls the charater
        # the user input
      end

      film_data = char_data["films"]
      #  we will make film_data equal the values of films within the hash char_data

     new_array= []
     # we make a new array that will contain movies
    film_data.each do |movie_urls|
      # for the film_data elements we will do the following for each
       new_data = RestClient.get(movie_urls)
       # extract the the info from the movie urls
       formatted_new_data = JSON.parse(new_data)
       # that extracted data will now be parsed and the result will equal
       # formatted_new_data

       new_array.push(formatted_new_data)
       # push the new data into the array
      end
      new_array
      # print the array


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
  # the films hash we just created will now give us the title of each movie
    films_hash.each do |film_info|
       puts film_info["title"]
       # look within each element in the films_hash
       #and put the value for the key "title "
  end
end


def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
