require 'json'
require_relative '../labels/label_methods'
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
    add_author(author)
    save_book
  end

  def save_book
    return if @books.empty?

    file = './books/books.json'
    File.new(file, 'w+') unless File.exist?(file)

    data = []

    @books.each do |book|
      data << { title: book.title, publisher: book.publisher,
                cover_state: book.cover_state, publish_date: book.publish_date }
    end
    File.write(file, JSON.generate(data))
  end

  def list_all_books
    if @books.empty?
      puts "The books list is empty, please add some books...\n\n"
    else
      puts 'Books list:'
      @books.each_with_index do |book, index|
        print "#{index}) Title: #{book.title}, Publisher: #{book.publisher}, "
        print "Publish date: #{book.publish_date}, Cover state: #{book.cover_state}\n"
      end
    end
  end

  def load_all_books
    data = []
    file = './books/books.json'
    return data unless File.exist?(file) && File.read(file) != ''

    JSON.parse(File.read(file)).each do |book|
      new_book = Book.new(book['title'], book['publisher'], book['cover_state'], book['publish_date'])
      data << new_book
    end
    data
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
end
