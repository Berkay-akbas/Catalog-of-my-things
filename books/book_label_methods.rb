require 'json'
require_relative 'label'
require_relative '../authors/author'
require_relative '../genre'

module BookAndLabelMethods
  def create_book
    title = set_title
    author_first = set_author_first
    author_last = set_author_last
    publisher = set_publisher
    cover_state = set_cover_state
    genre_type = set_genre
    publish_date = set_publish_date
    label = add_label
    puts "#{title} by #{author_first} #{author_last} with a #{cover_state} cover state was successfully created!"
    puts '-' * 60
    @books = load_all_books if @books.length.zero?
    author = Author.new(author_first, author_last)
    genre = Genre.new(genre_type)
    book1 = Book.new(title, publisher, cover_state, publish_date)
    book1.label = label
    book1.author = author
    book1.genre = genre
    @books << book1
    save_book
  end

  def save_book
    books_list = []
    @books.each do |book|
      books_list << { title: book.title, publisher: book.publisher, cover_state: book.cover_state,
                      publish_date: book.publish_date }
    end
    File.write('books.json', books_list.to_json)
  end

  def add_label
    label_type = set_label_type
    color = set_color
    @labels = load_all_labels if @labels.length.zero?
    label1 = Label.new(label_type, color)
    @labels << label1
    labels_list = []
    @labels.each do |label|
      labels_list << { title: label.title, color: label.color }
    end
    File.write('labels.json', labels_list.to_json)
    label1
  end

  def list_all_labels
    puts "Labels list:\n\n"
    @labels = load_all_labels
    if @labels.length.zero?
      puts "List is empty, please add some labels...\n\n"
    else
      @labels.each_with_index do |label, index|
        print "#{index}) Title: #{label.title}, Color: #{label.color} \n\n"
      end
    end
  end

  def load_all_labels
    file = 'labels.json'
    labels = []
    if File.exist?(file) && File.read(file) != ''
      labels = JSON.parse(File.read(file)).map do |label|
        Label.new(label['title'], label['color'])
      end
    end
    labels
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

def set_title
  puts 'Enter the title of the book:'
  gets.chomp
end

def set_author_first
  puts 'Enter the first name of the author:'
  gets.chomp
end

def set_author_last
  puts 'Enter the last name of the author:'
  gets.chomp
end

def set_publisher
  puts 'Enter the publisher of the book:'
  gets.chomp
end

def set_cover_state
  puts 'Enter the cover state of the book: (e.g. "good" or "bad")'
  gets.chomp
end

def set_genre
  puts 'Enter the genre of the book: (e.g. Comedy, History...)'
  gets.chomp
end

def set_publish_date
  puts 'Enter the publish date of the book: (e.g. 2022/09/10)'
  gets.chomp
end

def set_label_type
  puts 'Give a label for the book: (e.g. Gift, New...)'
  gets.chomp
end

def set_color
  puts 'Choose a color for the book\'s label: (e.g. Pink, Black, Gold...)'
  gets.chomp
end
