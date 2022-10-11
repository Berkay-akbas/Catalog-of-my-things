require_relative './books/book'
require_relative './books/book_methods'
require 'json'

class App
  def initialize
    @books = []
    @labels = []
  end

  include BookMethods

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
    end
  end
end
