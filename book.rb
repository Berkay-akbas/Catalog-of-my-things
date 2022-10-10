require_relative 'item'

class Book < Item
  def initialize(publisher, cover_state)
  
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    @archived || @cover_state === 'bad'
  end
end

# book = Book.new('Virag', 'good')
# puts book.can_be_archived?()