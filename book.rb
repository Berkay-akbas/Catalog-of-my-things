require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(publisher, cover_state, publish_date)
    super(publish_date)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end

# book = Book.new('Virag', 'good', '2022-09-08')
# puts book.can_be_archived?()
