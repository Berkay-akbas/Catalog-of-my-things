require 'securerandom'

class Label
  attr_accessor :items, :color, :title
  attr_reader :id

  def initialize(title, color)
    @id = SecureRandom.hex(5)
    @title = title
    @color = color
    @items = []
  end

  def to_json(*_args)
    "{
      \"id\": \"#{id}\",
      \"title\": \"#{title}\",
      \"color\": \"#{color}\"
    }"
  end

  def add_items(item)
    @items << item
    # item.label = self
  end
end
