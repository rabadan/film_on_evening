require 'rspec'
require_relative '../lib/film'
require_relative '../lib/film_collection'

describe Film do
  let(:file_path) { File.dirname(__FILE__) + '/fixtures/data/001.txt' }
  let(:film_data) do
    { title: 'Побег из Шоушенка', author: 'Фрэнк Дарабонт', year: '1994' }
  end

  context '#initialize' do
    it 'initialize film from input data' do
      film = Film.new(
        title: film_data[:title],
        author: film_data[:author],
        year: film_data[:year]
      )
      expect(film.author).to eq film_data[:author]
      expect(film.title).to eq film_data[:title]
      expect(film.year).to eq film_data[:year]
    end
  end

  context '#new_from_file' do
    it 'loads films from file' do
      film = Film.new_from_file(file_path)
      expect(film.author).to eq film_data[:author]
      expect(film.title).to eq film_data[:title]
      expect(film.year).to eq film_data[:year]
    end
  end
end
