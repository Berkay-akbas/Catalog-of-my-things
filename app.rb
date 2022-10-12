require_relative './books/book_methods'
require_relative './books/book'
require_relative './labels/label_methods'
require_relative './games/game_methods'
require_relative './games/game'
require_relative './authors/author_methods'
require_relative './authors/author'
require 'json'

class App
  def initialize
    @books = []
    @labels = []
    @genres = []
    @authors = []
    @games = []
  end

  include BookMethods
  include LabelMethods
  include GameMethods
  include AuthorMethods

  def add_music_album
    print 'Declare if on spotify or not [Y/n]: '
    spotify_choice = gets.chomp
    on_spotify = true if %w[Y y].include?(spotify_choice)
    on_spotify = false if %w[N n].include?(spotify_choice)
    print 'Enter the date the album was published: '
    publish_date = gets.chomp
    print 'What is the source of the album: '
    source = gets.chomp
    print 'What is the label title the album is under: '
    label_title = gets.chomp
    print 'Label studio: '
    studio = gets.chomp
    print 'select the genre of the genre of the album: '
    genre = gets.chomp
    puts "Music album created successfully\n \n"

    music_albums << MusicAlbum.new(on_spotify, publish_date)
    sources << Source.new(source)
    labels << Label.new(label_title, studio)
    genres << Genre.new(genre)
  end

  def run
    print "Welcome to Catalog of my Things! \n\n"
    loop do
      puts "Please choose an option by entering a number: \n
      1 - List all books
      2 - List all music albums
      3 - List of games
      4 - List all genres (e.g 'Comedy', 'Thriller')
      5 - List all labels (e.g. 'Gift', 'New')
      6 - List all authors (e.g. 'Stephen King')
      7 - Add a book
      8 - Add a music album
      9 - Add a game
      10 - Exit"
      option = gets.chomp.to_i
      break if option == 10

      options(option)
    end
  end

  def options(option)
    case option
    when 1
      list_all_books
    when 5
      list_all_labels
    when 7
      create_book
    when 3
      list_all_games
    when 9
      add_game
    when 6
      list_authors
    end
  end
end
