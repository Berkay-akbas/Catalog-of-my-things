require 'json'

module BookMethods
  def create_book
    title = set_title
    publisher = set_publisher
    cover_state = set_cover_state
    publish_date = set_publish_date
    label = add_label
    puts "#{title.capitalize!} by #{publisher.capitalize!} with a #{cover_state} cover state was successfully created!"
    puts '-' * 60
    @books = load_all_books if @books.length.zero?
    book1 = Book.new(title, publisher, cover_state, publish_date)
    book1.label = label
    @books << book1
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

  def set_title
    puts 'Enter the title of the book:'
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
