require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(publisher, cover_state)
    super()
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    @archived || @cover_state == 'bad'
  end
end

# book = Book.new('Virag', 'good')
# puts book.can_be_archived?()
