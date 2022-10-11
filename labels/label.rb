class Label
  attr_accessor :title, :color
  attr_reader :items, :id

  def initialize(title, color)
    @id = Random.rand(1..1000)
    @title = upcase_word(title)
    @color = color
    @items = []
  end

  def upcase_word(val)
    val.upcase!
  end

  def add_item(item)
    @items.push(item)
    item.label = self
  end
end

