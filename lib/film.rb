class Film
  attr_reader :title, :author, :year

  def initialize(title:, author:, year:)
    @title = title
    @author = author
    @year = year
  end

  def self.new_from_file(file_path)
    raise "error read file: #{file_path}" unless File.exist?(file_path)

    f = File.new(file_path, "r:UTF-8")
    data = f.readlines.map(&:chomp)
    f.close

    new(title: data[0], author: data[1], year: data[2])
  end

  def to_hash
    { title: @title, author: @author, year: @year }
  end

  def to_s
    "#{@author} — #{@title} (#{@year})"
  end

  def ==(obj)
    @title == obj.title &&
    @author == obj.author &&
    @year == obj.year
  end
end
