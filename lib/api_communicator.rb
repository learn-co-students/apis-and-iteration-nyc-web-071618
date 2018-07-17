require 'rest-client'
require 'json'
require 'pry'

def find_character_hash(character_name)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  found_character = character_hash['results'].find do |character|
    character['name'].downcase == character_name.downcase
  end
  found_character
end

def get_character_movies_from_api(character_name)
  found_character = find_character_hash(character_name)
  character_films = found_character['films']
  films_arr = character_films.map do |film_url|
    film_info = RestClient.get(film_url)
    film_hash = JSON.parse(film_info)
    film_hash
  end
 films_arr
end

def parse_film_crawl(film)
  crawl_sentences_arr = film['opening_crawl'].split("\r\n")
  crawl_sentences_arr.each do |sentence|
    puts sentence
    sleep(2)
  end
end


def parse_character_movies(films_arr)
  films_arr.each do |film|
    puts film['title'].upcase
    system('say "beep"')
    parse_film_crawl(film)
    puts "🛸" * 15
  end
end

def show_character_movies(character_name)
  films_arr = get_character_movies_from_api(character_name)
  parse_character_movies(films_arr)
end
