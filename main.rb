require_relative "lib/film"
require_relative "lib/film_collection"
require_relative "lib/kinopoisk_parser"

# Ссылка на загрузку фильмов
url_parsing_films = "https://www.kinopoisk.ru/top/lists/1/"

# Инифиализируем парсер
kinopoisk_parser = KinopoiskParser.new(url_parsing_films)

# Если была ошибка при загрузке - выводим ее и выходим
unless kinopoisk_parser.error_text.nil?
  puts kinopoisk_parser.error_text
  exit 1
end

# парсим фильмы с страницы
kinopoisk_parser.parsing_films

# Если нет ни одного фильма, выводим ошибку, выходим
if kinopoisk_parser.size == 0
  puts "Не удалось загрузить ни одного фильма"
  exit 1
end

# Загружаем фильмы в колекцию
collection = FilmCollection.new_from_array(kinopoisk_parser.films)

puts "Программа «Фильм на вечер» v.0.2"
puts "Фильм какого режиссера вы хотите сегодня посмотреть?"

# загружаем авторов
authors_list = collection.authors

# спрашиваем у пользователя авторов
input_author = 0
until input_author.between?(1, authors_list.length)
  authors_list.each_with_index {|item, i|
    puts "#{i+1}. #{item}"
  }

  print "Ваш выбор:"
  input_author = STDIN.gets.to_i
end

puts "И сегодня вечером рекомендую посмотреть:"
list_films_from_author = collection.films_from_author(authors_list[input_author-1])
puts list_films_from_author.sample
