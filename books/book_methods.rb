require 'json'
require_relative '../labels/label_methods'
require_relative '../authors/author_methods'
require_relative '../date_validation'

module BookMethods
  def create_book
    title = set_title
    author_first = set_author_first
    author_last = set_author_last
    publisher = set_publisher
    cover_state = set_cover_state
    genre_type = set_genre
    publish_date = set_publish_date
    label = add_label
    puts "#{title} by #{author_first} #{author_last} with a #{label.color} #{label.title} label was successfully added!"
    @books = load_all_books if @books.length.zero?
    author = Author.new(author_first, author_last)
    genre = Genre.new(genre_type)
    book1 = Book.new(title, publisher, cover_state, publish_date)
    add_properties(book1, label, author, genre)
    save_book
  end

  def add_properties(book1, label, author, genre)
    book1.label = label
    book1.author = author
    book1.genre = genre
    @books << book1
    add_author(author)
    save_book
    @authors << author
    @genres << genre
  end

  def save_book
    return if @books.empty?

    file = './books/books.json'
    File.new(file, 'w+') unless File.exist?(file)

    data = []

    @books.each do |book|
      data << { title: book.title, publisher: book.publisher,
                cover_state: book.cover_state, publish_date: book.publish_date, author_first_name: book.author.first_name,
                author_last_name: book.author.last_name,
                genre: book.genre, label: book.label }
    end
    File.write(file, JSON.generate(data))
  end

  def list_all_books
    if @books.empty?
      puts "The books list is empty, please add some books...\n\n"
    else
      puts 'Books list:'
      @books.each_with_index do |book, index|
        print "#{index}) Title: #{book.title} | Publisher: #{book.publisher} | "
        print "Author: #{book.author.first_name} #{book.author.last_name} | "
        print "Genre: #{book.genre.name} | "
        print "Label and Color: #{book.label.title} #{book.label.color} | "
        print "Publish date: #{book.publish_date} | Cover state: #{book.cover_state} \n"
      end
    end
  end

  def load_all_books
    data = []
    file = './books/books.json'
    return data unless File.exist?(file) && File.read(file) != ''

    JSON.parse(File.read(file)).each do |book|
      new_book = Book.new(book['title'], book['publisher'], book['cover_state'], book['publish_date'])
      author = Author.new(book['author_first_name'], book['author_last_name'])
      new_book.author = author
      genre = Genre.new(book['genre']['name'])
      new_book.genre = genre
      label = Label.new(book['label']['title'], book['label']['color'])
      new_book.label = label
      data << new_book
    end
    data
  end
end

def set_title
  title = ''
  loop do
    puts 'Enter the title of the book:'
    title = gets.chomp
    break if title != ''
  end
  title = title.split.each(&:capitalize!)
  title.join(' ')
end

def set_author_first
  author_first = ''
  loop do
    puts 'Enter the first name of the author:'
    author_first = gets.chomp
    author_first.capitalize!
    break if author_first != ''
  end
  author_first
end

def set_author_last
  author_last = ''
  loop do
    puts 'Enter the last name of the author:'
    author_last = gets.chomp
    author_last.capitalize!
    break if author_last != ''
  end
  author_last
end

def set_publisher
  publisher = ''
  loop do
    puts 'Enter the publisher of the book:'
    publisher = gets.chomp
    publisher.capitalize!
    break if publisher != ''
  end
  publisher
end

def set_cover_state
  cover_state = ''
  loop do
    puts 'Enter the cover state of the book: (e.g. "good" or "bad")'
    cover_state = gets.chomp
    cover_state.downcase!
    break if %w[good bad].include?(cover_state)
  end
  cover_state
end

def set_genre
  genre = ''
  loop do
    puts 'Enter the genre of the book: (e.g. Comedy, History...)'
    genre = gets.chomp
    break if genre != ''
  end
  genre
end

def set_publish_date
  pub_date = ''
  loop do
    puts 'Enter the publish date of the book: (e.g. 2022-09-10)'
    date = gets.chomp
    pub_date = date
    valid_date = validate_date(date)
    break if valid_date
  end
  pub_date
end
