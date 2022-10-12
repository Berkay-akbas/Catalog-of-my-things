require 'json'

def retrieve_albums(music_albums)
  data = JSON.parse(File.read('./storage/album'))
  data.each do |album|
          music_albums << MusicAlbum.new(album['on_spotify'],
          album['publish_date'])
          end
    end