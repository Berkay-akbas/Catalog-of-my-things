class Author
  attr_reader :items, :id
  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @id = Random.rand(1..1000)
    @items = []
  end

  def add_item(item)
    @items << item
    item.author = self
  end
end
