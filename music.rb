require './item'

class MusicAlbum < Item
  attr_accessor :on_spotify, :publish_date
          
  def initialize (on_spotify,publish_date)
     super(public_date)
     @on_spotify = on_spotify             
  end

  def to_json(*_args)
    "{
     \"on_spotify\": \"#{on_spotify}\",
     \"publish_date\":\"#{public_date}\"     
    }"     
  end

  # private

  




