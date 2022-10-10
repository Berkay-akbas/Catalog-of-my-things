require_relative 'app'

def main
  print "Welcome to Catalog of my Things!\n"
  # app = App.new
  loop do
    puts "Please choose an option by entering a number:
    1 - List all books
    2 - List all music albums
    3 - List of games
    4 - List all genres (e.g 'Comedy', 'Thriller')
    5 - List all labels (e.g. 'Gift', 'New')
    6 - List all authors (e.g. 'Stephen King')
    7 - Add a book
    8 - Add a music album
    9 - Add a game
    10 - Exit"
    option = gets.chomp
    # app.run(option)
    break if option == '10'
  end
end

main
