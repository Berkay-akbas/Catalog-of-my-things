require './item'

class MusicAlbum < Item
  attr_accessor :on_spotify, :publish_date, :archived, :title, :author, :genre, :label

  def initialize(on_spotify, publish_date)
    super(publish_date)
    @on_spotify = on_spotify
  end

  def to_json(*_args)
    "{
      \"on_spotify\": \"#{on_spotify}\",
      \"publish_date\": \"#{publish_date}\"
    }"
  end

  # private

  def can_be_archived?()
    parent = super()
    return true if parent || @on_spotify

    false
  end
end
