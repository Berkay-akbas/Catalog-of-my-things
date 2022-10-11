require 'json'
require_relative '../label'

module BookMethods
  def create_book
    puts 'Enter the title of the book:'
    title = gets.chomp
    puts 'Enter the publisher of the book:'
    publisher = gets.chomp
    puts 'Enter the cover state of the book: (e.g. "good" or "bad")'
    cover_state = gets.chomp
    puts 'Enter the publish date of the book: (e.g. 2022/09/10)'
    publish_date = gets.chomp
    puts 'Give a label for the book: (e.g. Gift, New...)'
    label_type = gets.chomp
    puts 'Choose a color for the book\'s label: (e.g. Pink, Black, Gold...)'
    color = gets.chomp
    puts "#{title.capitalize!} by #{publisher.capitalize!} with a #{cover_state} cover state was successfully created!"
    puts '-' * 60
    @books = load_all_books if @books.length.zero?
    book = Book.new(title, publisher, cover_state, publish_date)
    label = Label.new(label_type, color)
    book.label = label
    @books << book
    @labels << label
    books_list = []
    @books.each do |book|
      books_list << { title: book.title, publisher: book.publisher, cover_state: book.cover_state,
                      publish_date: book.publish_date }
    end
    File.write('books.json', books_list.to_json)
  end

  def list_all_books
    puts "Books list:\n\n"
    @books = load_all_books
    if @books.length.zero?
      puts "List is empty, please add some books...\n\n"
    else
      @books.each_with_index do |book, index|
        print "#{index}) Title: #{book.title}, Publisher: #{book.publisher},"
        print " Cover State: #{book.cover_state}, Publish Date: #{book.publish_date}\n\n"
      end
    end
  end

  def load_all_books
    file = 'books.json'
    books = []
    if File.exist?(file) && File.read(file) != ''
      books = JSON.parse(File.read(file)).map do |book|
        Book.new(book['title'], book['publisher'], book['cover_state'], book['publish_date'])
      end
    end
    books
  end
end
