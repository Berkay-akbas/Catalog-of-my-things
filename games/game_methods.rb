require 'json'
require_relative '../genre'
require_relative '../item'
require_relative '../authors/author'
require_relative '../authors/author_methods'
require_relative '../books/book_methods'
require_relative '../labels/label_methods'
require_relative '../games/game_methods'
require_relative '../date_validation'

module GameMethods
  def input(message)
    print message
    gets.chomp
  end

  def add_game
    author_first_name = input('Author First Name?: ')
    author_last_name = input('Author Last Name?: ')
    multiplayer = input('Is the game multiplayer? [true, false]: ')
    last_played = sets_date('Last played at')
    publish_date = sets_date('Publish date')
    genre = Genre.new(input('Specify a Genre name: '))
    label = add_label
    author = Author.new(author_first_name, author_last_name)
    game = Game.new(multiplayer, last_played, publish_date)
    game.author = author
    game.genre = genre
    @genres << genre
    game.label = label
    @games << game
    add_author(author)
    store
    puts "The Game has been created successfully \n\n"
  end

  def sets_date(val)
    pub_date = ''
    loop do
      puts "#{val}?: (e.g. 2022-09-10)"
      date = gets.chomp
      pub_date = date
      valid_date = validate_date(date)
      break if valid_date
    end
    pub_date
  end

  def store
    return if @games.empty?

    file = './games/games.json'
    File.new(file, 'w+') unless File.exist?(file)

    data = []

    @games.each do |game|
      data << { author_first_name: game.author.first_name, author_last_name: game.author.last_name,
                multiplayer: game.multiplayer, publish_date: game.publish_date, last_played:
                game.last_played_at, genre: game.genre.name,
                label_title: game.label.title, label_color: game.label.color }
    end
    File.write(file, JSON.generate(data))
  end

  def list_all_games
    if @games.empty?
      puts "The games list is empty, please add some games...\n\n"
    else
      puts 'Games list:'
      @games.each_with_index do |game, index|
        print "#{index}) Author: #{game.author.first_name} #{game.author.last_name} | "
        print "Multiplayer: #{game.multiplayer} | "
        print "Publish date: #{game.publish_date} | Last Played At: #{game.last_played_at} | "
        print "Genre: #{game.genre.name} | Label and Color: #{game.label.title} #{game.label.color}\n"
      end
    end
  end

  def load_all_games
    data = []
    file = './games/games.json'
    return data unless File.exist?(file) && File.read(file) != ''

    JSON.parse(File.read(file)).each do |game|
      author = Author.new(game['author_first_name'], game['author_last_name'])
      genre = Genre.new(game['genre'])
      label = Label.new(game['label_title'], game['label_color'])
      game = Game.new(game['multiplayer'], game['last_played'], game['publish_date'])
      game.author = author
      game.genre = genre
      game.label = label
      data << game
    end
    data
  end
end
