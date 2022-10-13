require 'securerandom'

class Genre
  attr_reader :items, :id
  attr_accessor :name

  def initialize(name)
    @id = SecureRandom.hex(5)
    @name = name
    @items = []
  end

  def to_json(*_args)
    "{
    \"id\": \"#{id}\",
    \"name\":\"#{name}\"
     }"
  end

  def add_items(item)
    @items.push(item)
    item.label = self
  end
end
