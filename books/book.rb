require_relative '../item'

class Book < Item
  attr_accessor :publisher, :cover_state, :title

  def initialize(title, publisher, cover_state, publish_date)
    super(publish_date)
    @title = capitalize_word(title)
    @publisher = capitalize_word(publisher)
    @cover_state = cover_state
  end

  def capitalize_word(val)
   val = val.split(' ').each {|word| word.capitalize! }
   val.join(' ')
  end

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end

