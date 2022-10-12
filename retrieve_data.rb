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


def retrieve_sources(sources)
  data = JSON.parse(File.read('./storage/source.json'))
  data.each do |source|
    sources << Source.new(source['name'])
  end
end

def retrieve_labels(labels)
  data = JSON.parse(File.read('./storage/label.json'))
  data.each do |label|
    labels << Label.new(label['title'], label['color'])
  end
end


def retrieve_data(item)
  retrieve_albums(item.music_albums)
  retrieve_genres(item.genres)
  retrieve_sources(item.sources)
  retrieve_labels(item.labels)
end
