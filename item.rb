# require_relative 'genre'
# require_relative 'author'
# require_relative 'label'

class Item
  # attr_accessor :genre, :author, :label, :archived
  # attr_reader :id, :publish_date

  def initialize(publish_date, archived: false)
    @id = Random.rand(1..1000)
    @publish_date = publish_date
    @archived = archived
  end

  # def create_genre
  #   @genre = Genre.new
  # end

  # def create_author
  #   @author = Author.new
  # end

  # def create_label
  #   @label = Label.new
  # end
  def move_to_archive
    self.archived = true if can be archived?
    self .archived = false unless can_be_archive? 
  end

def author =(author)
  @author = author
  author.Item << self
end

def genre =(genre)
  @genre = genre
  genre.items << self
end

def source = (source)
  @source = source
  source.items << self
end

def label = (label)
  @label = label
  @label.items << self
end
 
def can_be_archive?
  Date.strptime(@public_date, '%Y-%m-%d') <
   DateTime.now,prev_Year(10)
end
end 
