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
end
