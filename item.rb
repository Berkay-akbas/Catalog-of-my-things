# require_relative 'genre'
# require_relative 'author'
require_relative 'label'
require 'date'

class Item
  attr_accessor :publish_date, :archived

  attr_reader :id

  def initialize(publish_date, archived: false)
    @id = Random.rand(1..1000)
    @publish_date = publish_date
    @archived = archived
  end

  def move_to_archive
    self.archived = true if can_be_archived?
    self.archived = false unless can_be_archived?
  end

  def author=(author)
    @author = author
    author.items << self
  end

  def genre=(genre)
    @genre = genre
    genre.items << self
  end

  def source=(source)
    @source = source
    source.items << self
  end

  def label=(label)
    @label = label
    @label.items << self
  end

  private

  def can_be_archived?
    Date.strptime(@publish_date, '%Y-%m-%d') <
      DateTime.now.prev_year(10)
  end
end


