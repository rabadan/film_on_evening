require_relative 'film'

class FilmCollection
  attr_reader :films, :authors

  def initialize
    @films = []
    @authors = []
  end

  def self.new_from_file(film_dir_path)
    film_collection = new

    raise '' "Каталог с фильмами не обнаружен #{film_dir_path}" unless Dir.exist?(film_dir_path)

    Dir.glob("#{film_dir_path}*.txt").each do |film_path|
      film_collection.add_film(Film.new_from_file(film_path))
    end

    film_collection
  end

  def self.new_from_array(input_array)
    film_collection = new
    input_array.each do |item|
      film_collection.add_film(Film.new(item))
    end
    film_collection
  end

  def add_film(film)
    @films << film
    add_author(film.author)
  end

  def add_author(author)
    @authors << author unless @authors.include?(author)
  end

  def films_from_author(author)
    @films.select { |film| film.author == author }
  end

  def films_length
    @films.length
  end
end
