require 'json'
require_relative '../item'
require_relative '../authors/author'
require_relative '../authors/author_methods'
require_relative '../books/book_methods'
require_relative '../labels/label_methods'
require_relative '../games/game_methods'
require_relative '../date_validation'

module GenreMethods
  def input(message)
    print message
    gets.chomp
  end

  def store_genre
    return if @genres.empty?

    file = './storage/genres.json'
    File.new(file, 'w+') unless File.exist?(file)

    data = []

    @genres.each do |genre|
      data << { name: genre.name }
    end
    File.write(file, JSON.generate(data))
  end

  def load_all_genres
    file = './storage/genres.json'
    data = []
    return data unless File.exist?(file) && File.read(file) != ''

    JSON.parse(File.read(file)).map do |genre|
      new_genre = Genre.new(genre['name'])
      data << new_genre
    end
    data
  end

  def list_all_genres
    if @genres.empty?
      puts 'The genres list is empty, please add some items with genres...'
    else
      puts "🔹Genres list:\n\n"
      @genres.each_with_index do |genre, index|
        puts "#{index}) Genre name: #{genre.name} \n"
      end
    end
  end
end
