require_relative '../books/book'

describe Book do
  before :each do
    @book = Book.new('awesome books', 'micronaut', 'bad', '2022-02-07')
  end
  context 'When creating a new instance of the Book class' do
    it 'should have the following properties: title, publisher, cover state, publish date, id' do
      expect(@book.title).to eql('awesome books')
      expect(@book.publisher).to eql('micronaut')
      expect(@book.cover_state).to eql('bad')
      expect(@book.publish_date).to eql('2022-02-07')
      expect(@book.publish_date).to be_kind_of String
      expect(@book.id).to be_kind_of String
    end
    it 'should be an instance of the Book class' do
      expect(@book).to be_instance_of Book
    end
    it 'should add genre and author properties as well' do
      genre = Genre.new('Comedy')
      author = Author.new('Virag', 'Kormoczy')
      @book.genre = genre
      @book.author = author
      expect(@book.genre).to be_instance_of Genre
      expect(@book.author).to be_instance_of Author
      expect(@book.genre.name).to eql('Comedy')
      expect(@book.author.first_name).to eql('Virag')
    end
  end

  context 'When testing with the can_be_archived method' do
    it 'should return true if the cover state is bad' do
      expect(@book.can_be_archived?).to be true
    end
    it 'should return true if the publish date is older than 10 years' do
      @book.publish_date = '2000-10-30'
      expect(@book.can_be_archived?).to be true
    end
    it 'should return false if the publish date is not older than 10 years and the cover state is good' do
      @book.cover_state = 'good'
      expect(@book.can_be_archived?).to be false
    end
  end
end
