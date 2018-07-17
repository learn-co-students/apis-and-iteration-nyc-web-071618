require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  cur_page = 1
  total_page = 1
  res = {}
  while cur_page <= total_page
    all_characters = RestClient.get('http://www.swapi.co/api/people/',{:page=>cur_page})
    
    character_hash = JSON.parse(all_characters)
    #total_page = character_hash["count"]
    character_hash["results"].each {|result|
      if result["name"].downcase.include?( character )
        result["films"].each {|film_url|
          if res[result["name"]] == nil
            res[result["name"]] = []
          end
          res[result["name"]] << helper(film_url)
        }
      end
    }
    cur_page += 1
  end
  res
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
  # some iteration magic and puts out the movies in a nice list
  if films_hash.size == 0 
    puts "There is nothing to be found"
    return
  end
  films_hash.each {|name, films|
    puts name
    films.each {|film|
      #puts film
      puts "\t#{film['title']}"
    }
  }
  puts ""
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
def helper(film_url)
  JSON.parse(RestClient.get(film_url))
end