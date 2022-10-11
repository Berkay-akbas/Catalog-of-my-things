# require_relative 'load_data'
require_relative 'book'
require 'json'

class App 
  def initialize
    @books = []
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
      books_options(option)
    end
  end

    def books_options(option)
      case option
      when 1
        puts "List all books: \n\n"
        list_all_books
      when 7
        puts "Add a book: \n\n"
        create_book
      end
    end


  def create_book
    puts 'Enter the title of the book:'
    title = gets.chomp
    puts 'Enter the publisher of the book:'
    publisher = gets.chomp
    puts 'Enter the cover state of the book: (e.g. "good" or "bad")'
    cover_state = gets.chomp
    puts 'Enter the publish date of the book: (e.g. 2022/09/10)'
    publish_date = gets.chomp
    puts "#{title.capitalize} by #{publisher.capitalize} with a #{cover_state} cover state was successfully created on #{publish_date}. \n\n"
    # @books = load_all_books if @books.length.zero?
    @books << Book.new(publisher, cover_state, publish_date)
    books_list = []
    @books.each do |book|
      books_list << { publisher: book.publisher, cover_state: book.cover_state, publish_date: book.publish_date }
    end
    File.write('books.json', books_list.to_json)
  end

  def list_all_books
    
  end
end