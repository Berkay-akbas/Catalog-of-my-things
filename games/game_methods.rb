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
    # last_played = input('Last played at?: ')
    # publish_date = input('Publish date?: ')
    last_played = sets_date('Last played at')
    publish_date = sets_date('Publish date')
    genre = Genre.new(input('Specify a Genre name: '))
    label = Label.new(input('What is the label title?: '), input('What is the label color?: '))
    author = Author.new(author_first_name, author_last_name)
    game = Game.new(multiplayer, last_played, publish_date)
    game.author = author
    game.genre = genre
    @genres << genre
    game.label = label
    @labels << label
    game.move_to_archive
    store(game)
    add_author(author)
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

  def store(game)
    File.new('./games/games.json', 'w+') unless File.exist?('./games/games.json')

    if File.empty?('./games/games.json')
      games = []
    else
      data = File.read('./games/games.json').split
      games = JSON.parse(data.join)
    end

    games.push({ 'multiplayer' => game.multiplayer, 'last_played_at' => game.last_played_at,
                 'publish_date' => game.publish_date, 'genre' => game.genre,
                 'label' => game.label, 'author' => game.author })
    File.write('./games/games.json', JSON.generate(games))
  end

  def list_all_games
    File.new('./games/games.json', 'w+') unless File.exist?('./games/games.json')

    if File.empty?('./games/games.json')
      puts 'Games list is empty.'
    else
      data = File.read('./games/games.json').split
      games = JSON.parse(data.join)
      puts 'Games list:'
      games.each_with_index do |game, key|
        puts "#{key + 1}-[Game] Multiplayer: #{game['multiplayer']} | " \
             "Last Played: #{game['last_played_at']} | Publish Date: #{game['publish_date']}
              | Genre: #{game['genre']['name']} | Label: #{game['label']} | Author: #{game['author']}"
      end
    end
  end
end
