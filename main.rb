require_relative 'lib/film'
require_relative 'lib/film_collection'
require_relative 'lib/kinopoisk_parser'

# link to load films
url_parsing_films = 'https://www.kinopoisk.ru/top/lists/1/'

# init parser
kinopoisk_parser = KinopoiskParser.new(url_parsing_films)

# parsing film on page
kinopoisk_parser.parsing_page

# If there was an error while loading - we print it and exit
unless kinopoisk_parser.error_text.nil?
  puts kinopoisk_parser.error_text
  exit 1
end

# If there is not a single movie, we print an error, we exit
if kinopoisk_parser.size.zero?
  puts 'Не удалось загрузить ни одного фильма'
  exit 1
end

# Download movies to the collection
collection = FilmCollection.new_from_array(kinopoisk_parser.films)

puts 'Программа «Фильм на вечер» v.0.2'
puts 'Фильм какого режиссера вы хотите сегодня посмотреть?'

# download authors
authors_list = collection.authors

# we ask the user of the authors
input_author = 0
until input_author.between?(1, authors_list.length)
  authors_list.each_with_index do |item, i|
    puts "#{i + 1}. #{item}"
  end

  print 'Ваш выбор:'
  input_author = STDIN.gets.to_i
end

puts 'И сегодня вечером рекомендую посмотреть:'
select_author = authors_list[input_author - 1]
list_films_from_author = collection.films_from_author(select_author)
puts list_films_from_author.sample
