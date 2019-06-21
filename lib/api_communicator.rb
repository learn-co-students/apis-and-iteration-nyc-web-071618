require 'rest-client'
require 'json'
require 'pry'

@all_characters = []
@films = []
@next_url = []
@done = FALSE

def get_character_movies_from_api(character)
  @all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(@all_characters)
  @films = character_hash["results"].collect do |results|
    if results['name'].downcase == character
      results['films']
    end
  end
  if @films.compact == []
    @next_url = character_hash["next"]

    @next_url = iterate_over_pagination(character)
  end
  if @films.compact == [] || @next_url == nil
    puts 'Character not found.'
  end

  return @films.compact
end

def iterate_over_pagination(character)
  @all_characters = RestClient.get(@next_url)
  character_hash = JSON.parse(@all_characters)
  @films = character_hash["results"].collect do |results|
    if results['name'].downcase == character
      results['films']
    end
  end
  character_hash["next"]
end

def prepare_urls(films_hash)
  films_hash.flatten
  film_num = films_hash.flatten.collect do |url|
    url[-2]
  end
  return film_num
end

def parse_character_movies(films_hash)
  film_num = prepare_urls(films_hash)
  film_titles = film_num.map do |i|
  film_arr = RestClient.get('http://www.swapi.co/api/films/' + i + '/')
  films_hash = JSON.parse(film_arr)
  films_hash['title']
   end
  return film_titles
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  film_titles = parse_character_movies(films_hash)
  puts film_titles
  return film_titles
 end
