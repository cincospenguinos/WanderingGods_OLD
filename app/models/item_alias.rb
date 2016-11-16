require 'data_mapper'
require_relative 'item'

# TODO: Convert this into something that monster can use as well? Like a general collection of aliases?
class ItemAlias
  include DataMapper::Resource

  property :id, Serial
  property :alias, String

  belongs_to :item
end