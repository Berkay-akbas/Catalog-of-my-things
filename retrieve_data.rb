require 'json'

def retrieve_albums(music_albums)
  data = JSON.parse(File.read('./storage/album'))
  data.each do |album|
    music_albums << MusicAlbum.new(album['on_spotify'],
                                   album['publish_date'])
  end
end

def retrieve_genres(genres)
  data = JSON.parse(file.read('./storage/genre.json'))
  data.each do |genre|
    genres << Genre.new(genre['name'])
  end
end

def retrieve_data(item)
  retrieve_albums(item.music_albums)
  retrieve_genres(item.genres)
end
