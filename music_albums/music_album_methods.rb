require 'json'
require_relative '../genres/genre'
require_relative '../item'
require_relative '../authors/author'
require_relative '../authors/author_methods'
require_relative '../books/book_methods'
require_relative '../labels/label_methods'
require_relative '../games/game_methods'
require_relative '../date_validation'
require_relative '../genres/genre_methods'

module MusicAlbumMethods
  def input(message)
    print message
    gets.chomp
  end

  def add_music_album
    on_spotify = input('Declare if on spotify or not [Y/N] ')
    publish_date = sets_date('Publish date')
    author_first_name = input('Author First Name?: ')
    author_last_name = input('Author Last Name?: ')
    genre = Genre.new(input('Genre name: '))
    label = add_label
    author = Author.new(author_first_name, author_last_name)
    music_album = MusicAlbum.new(on_spotify, publish_date)
    music_album.author = author
    music_album.genre = genre
    music_album.label = label
    @genres << genre
    @music_albums << music_album
    add_author(author)
    store_music_album
    store_genre
    puts "Music album created successfully\n \n"
  end

  def store_music_album
    return if @music_albums.empty?

    file = './storage/music_albums.json'
    File.new(file, 'w+') unless File.exist?(file)

    data = []

    @music_albums.each do |music_album|
      data << { author_first_name: music_album.author.first_name, author_last_name: music_album.author.last_name,
                on_spotify: music_album.on_spotify, publish_date: music_album.publish_date,
                genre_name: music_album.genre.name,
                label_name: music_album.label.title, label_color: music_album.label.color }
    end
    File.write(file, JSON.generate(data))
  end

  def list_all_music_albums
    if @music_albums.empty?
      puts 'There are no music albums in the library'
    else

      puts 'All Music Albums: '
      @music_albums.each do |music_album|
        print "Author: #{music_album.author.first_name} #{music_album.author.last_name} | "
        print "On Spotify: #{music_album.on_spotify} | "
        print "Publish Date: #{music_album.publish_date} | "
        print "Genre: #{music_album.genre.name} | "
        print "Label: #{music_album.label.title} | "
        print "Label Color: #{music_album.label.color} \n"
      end
    end
  end

  def load_all_music_albums
    data = []
    file = './storage/music_albums.json'
    return data unless File.exist?(file) && File.read(file) != ''

    JSON.parse(File.read(file)).map do |music_album|
      author = Author.new(music_album['author_first_name'], music_album['author_last_name'])
      genre = Genre.new(music_album['genre_name'])
      label = Label.new(music_album['label_name'], music_album['label_color'])
      music_album = MusicAlbum.new(music_album['on_spotify'], music_album['publish_date'])
      music_album.author = author
      music_album.genre = genre
      music_album.label = label
      data << music_album
    end
    data
  end
end
