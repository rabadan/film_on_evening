require 'nokogiri'
require 'open-uri'
# Class parsing Kinopoisk films
class KinopoiskParser
  attr_reader :error_text, :films

  def initialize(url)
    @url = url
    @films = []
  end

  def load_page_from_url(url)
    begin
      data = open(url)
    rescue SocketError => e
      @error_text = "Проблема с сетью: #{e.message}"
    end
    data
  end

  def structure_html
    page = load_page_from_url(@url)
    Nokogiri::HTML(page)
  end

  def parsing_page
    html = structure_html
    html.css('#block_left_pad #itemList tr td.news').each do |item|
      new_film = {
        title: item.css('a.all').text,
        author: item.css('span i a.lined').text,
        year: item.css('div span').text.match(/\((\d+?)\)/).to_a[1]
      }
      films << new_film
    end
  end

  def size
    films.length
  end
end
