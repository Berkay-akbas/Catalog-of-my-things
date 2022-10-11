require 'securerandom'
class Genre
          attr_accessor :id, :name, :items

def initialize(name)
  @id = Securerandom.hex(5)
  @name = name 
  @items = []
end           

def to_json(*_args)
  "{
          

  }"        