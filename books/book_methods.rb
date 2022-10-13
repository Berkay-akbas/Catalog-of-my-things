require 'json'
require_relative '../labels/label_methods'
require_relative '../authors/author_methods'
require_relative '../date_validation'

module BookMethods
  def create_book
    title = sets_names('title of the book')
    author_first = sets_names('first name of the author')
    author_last = sets_names('last name of the author')
    publisher = sets_names('publisher of the book')
    cover_state = set_cover_state
    genre_type = sets_names('genre of the book (e.g. Comedy, History)')
    publish_date = set_publish_date
    label = add_label
    puts "\n\n"
    puts "✅ #{title} by #{author_first} #{author_last} with #{label.color} #{label.title} label was successfully added!"
    puts "\n\n"
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
    @genres << genre
    add_author(author)
    store_genre
    save_book
  end

  def save_book
    return if @books.empty?

    file = './storage/books.json'
    File.new(file, 'w+') unless File.exist?(file)

    data = []

    @books.each do |book|
      data << { title: book.title, publisher: book.publisher,
                cover_state: book.cover_state, publish_date: book.publish_date,
                author_first_name: book.author.first_name,
                author_last_name: book.author.last_name,
                genre: book.genre, label: book.label }
    end
    File.write(file, JSON.generate(data))
  end

  def list_all_books
    if @books.empty?
      puts "The books list is empty, please add some books...\n\n"
    else
      puts "📚 Books list:\n\n"
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
    file = './storage/books.json'
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

def sets_names(val)
  name = ''
  loop do
    puts "Enter the #{val}:"
    name = gets.chomp
    name.capitalize!
    break if name != ''
  end
  name
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
