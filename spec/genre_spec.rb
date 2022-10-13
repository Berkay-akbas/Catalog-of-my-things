require_relative '../genres/genre'
require_relative '../books/book'

describe Genre do
  before :each do
    @genre = Genre.new('Fiction Series')
  end

  context 'When testing the Genre class' do
    it 'Should create an instance of the Genre class' do
      expect(@genre).to be_an_instance_of Genre
    end

    it 'Should add a genre to the items' do
      book = Book.new('awesome books', 'micronaut', 'bad', '2022-02-07')
      @genre.add_items(book)
      expect(@genre.items[0].publisher).to eql('micronaut')
    end
  end
end
