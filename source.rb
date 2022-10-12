require 'securerandom'

class Source
  attr_accessor :name
  attr_reader :id

  def initialize(name)
    @id = SecureRandom.hex(5)
    @name = name
    @items = []
  end

  def to_json(*_args)
    "{
      \"id\": \"#{id}\",
      \"name\": \"#{name}\"
    }"
  end

  def add_item(item)
    @items << item
 end
end
