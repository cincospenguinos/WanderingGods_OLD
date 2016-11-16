require 'data_mapper'
require_relative 'item'

class ItemAlias
  include DataMapper::Resource

  property :id, Serial
  property :alias, String

  belongs_to :item
end