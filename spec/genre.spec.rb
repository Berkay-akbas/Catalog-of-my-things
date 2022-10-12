require_relative '../genre'

describe Genre do
  before :each do
    @genre = Genre.new('Fiction Series')
  end