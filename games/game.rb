require_relative '../item'
require 'time'

class Game < Item
  attr_reader :multiplayer, :last_played_at, :publish_date, :author, :genre, :label

  def initialize(multiplayer, last_played_at, publish_date)
    super(publish_date)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  private :can_be_archived?

  def can_be_archived?
    now = Time.now
    last_played_at = Time.parse(@last_played_at)
    super && (now - last_played_at) / 60 / 60 / 24 / 365 > 2
  end
end
