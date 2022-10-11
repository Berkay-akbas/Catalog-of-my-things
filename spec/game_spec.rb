require_relative '../games/game'
require_relative '../games/game_methods'

describe Game do
  include GameMethods
  it 'Should be an instance of Game class' do
    author = Game.new(true, '2011/12/12', '2012/12/12')
    expect(author).to be_instance_of Game
  end

  it 'Should return true if the last played is 2 years ago from now' do
    game = Game.new(true, '2019/12/12', '2011-12-12')
    expect(game.can_be_archived?).to be true
  end
  it 'Should return false if the last played is within 2 years' do
    game = Game.new(true, '2021/12/12', '2011-12-12')
    expect(game.can_be_archived?).to be false
  end
end
