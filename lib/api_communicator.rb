require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
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

  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)


  #
  # array_of_character_info = character_hash["results"]
  # desired_character_bio = array_of_character_info.select do |character_bio|
  #   character_bio["name"].downcase == character
  # end
  #
  # film_array = desired_character_bio[0]["films"]

  film_api_array = get_character_films(character_hash, character)

  get_movie_details_from_api(film_api_array)

  # all_films_array = []
  #
  # film_array.each do |film|
  #   film_details = RestClient.get(film)
  #   film_hash = JSON.parse(film_details)
  #
  #   title = film_hash["title"]
  #   episode = film_hash["episode_id"]
  #   director = film_hash["director"]
  #   producer = film_hash["producer"]
  #   release_date = film_hash["release_date"]
  #   all_films_array << {title: title,
  #                           episode: episode,
  #                           director: director,
  #                           producer: producer,
  #                           release_date: release_date}
  # end
  #
  # return all_films_array

end

def get_character_films(character_hash, character)
  array_of_character_info = character_hash["results"]
  desired_character_bio = array_of_character_info.select do |character_bio|
    character_bio["name"].downcase == character
  end

  return desired_character_bio[0]["films"]
end


def get_movie_details_from_api(film_api_array)
  all_films_array = []

  film_api_array.each do |film|
    film_details = RestClient.get(film)
    film_hash = JSON.parse(film_details)

    title = film_hash["title"]
    episode = film_hash["episode_id"]
    director = film_hash["director"]
    producer = film_hash["producer"]
    release_date = film_hash["release_date"]
    all_films_array << {title: title,
                            episode: episode,
                            director: director,
                            producer: producer,
                            release_date: release_date}
  end

  return all_films_array

end

def parse_character_movies(films_array)
  # some iteration magic and puts out the movies in a nice list

  films_array.each do |film|
    title = film[:title]
    episode = film[:episode]
    director = film[:director]
    producer = film[:producer]
    release_date = film[:release_date]
    puts "Star Wars Episode #{episode}, #{title}"
    puts "Directed By: #{director}"
    puts "Produced By: #{producer}"
    puts "Release Date: #{release_date}"
    puts "*" * 50
    puts ""
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  puts ""
  puts "#{character.split.map(&:capitalize).join(' ')} has been in the following movies:"
  # the above "split" titlecases the character's name.
  puts ""
  parse_character_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
