require 'rspec'
require_relative '../lib/film'
require_relative '../lib/film_collection'

describe FilmCollection do
  let(:dir_path) { "#{File.dirname(__FILE__)}/fixtures/data/" }
  let(:collection) { FilmCollection.new_from_file(dir_path) }
  let(:authors) { ['Фрэнк Дарабонт', 'Роберт Земекис'] }
  let(:count_films) { 3 }
  let(:films) do
    [
      Film.new_from_file("#{dir_path}001.txt"),
      Film.new_from_file("#{dir_path}002.txt"),
      Film.new_from_file("#{dir_path}003.txt")
    ]
  end
  let(:author_find) { authors[1] }
  let(:movie_by_author) { [films[2]] }

  context '#films' do
    it 'correct initialization collection films from path dir' do
      collection.films.each do |film|
        expect(films.include?(film)).to eq true
      end
    end
  end

  context '#new_from_array' do
    it 'correct initialization collection films from array' do
      array_collection = FilmCollection.new_from_array(films)
      expect(array_collection.films).to match_array(films)
    end
  end

  context '#films_length' do
    it 'size film items' do
      expect(collection.films_length).to eq count_films
    end
  end

  context '#authors' do
    it 'loaded authors' do
      expect(collection.authors).to eq authors
    end
  end

  context '#films_from_author' do
    it 'getting movies by author' do
      expect(collection.films_from_author(author_find)).to eq(movie_by_author)
    end
  end
end
