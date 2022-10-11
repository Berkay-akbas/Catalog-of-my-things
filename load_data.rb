require 'json'

module LoadData
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
