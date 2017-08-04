require 'nokogiri'
require 'open-uri'

class KinopoiskParser
  attr_reader :error_text, :films

  def initialize(url)
    begin
      web_page = open(url)
    rescue SocketError => e
      @error_text = "Проблема с сетью: #{e.message}"
    end
    # web_page = File.read(__dir__ + "/kino.html")
    @html = Nokogiri::HTML(web_page)
    @films = []
  end

  def parsing_films
    @html.css("#block_left_pad #itemList tr td.news").each do |item|
      new_film = {
        title: item.css("a.all").text,
        author: item.css("span i a.lined").text,
        year: item.css("div span").text.match(/\((\d+?)\)/).to_a[1]
      }
      films << new_film
    end
  end

  def size
    films.length
  end
end
