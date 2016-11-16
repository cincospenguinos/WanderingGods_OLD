require 'data_mapper'

class Dungeon
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true


end