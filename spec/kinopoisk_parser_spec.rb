require 'rspec'
require 'open-uri'
require_relative '../lib/kinopoisk_parser'

describe KinopoiskParser do
  context '#parsing_films' do
    describe "mytest", :load_page_from_url do
      let(:page_path) {
        "#{__dir__}/fixtures/html/test_page.html"
      }
      let(:kinopoisk_parser) {
        kinopoisk_parser = KinopoiskParser.new("url")
        allow(kinopoisk_parser).to receive(:load_page_from_url).and_return(File.read(page_path))
        kinopoisk_parser.parsing_page
        kinopoisk_parser
      }
      let(:films) {
        [
            {:title=>"Побег из Шоушенка", :author=>"Фрэнк Дарабонт", :year=>"1994"},
            {:title=>"Зеленая миля", :author=>"Фрэнк Дарабонт", :year=>"1999"},
            {:title=>"Форрест Гамп", :author=>"Роберт Земекис", :year=>"1994"}
        ]
      }

      context '#films' do
        it "correct parsing films from path" do
          expect(kinopoisk_parser.films).to match_array(films)
        end
      end

      context '#size' do
        it "size film items" do
          expect(kinopoisk_parser.size).to eq(3)
        end
      end
    end
  end
end