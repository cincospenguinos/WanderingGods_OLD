require 'data_mapper'

require_relative 'item_alias'

class Item
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true
  property :description, Text, :required => true

  has n, :item_aliases

  belongs_to :room, :required => false
  # belongs_to :player, :required => false

  def add_alias(some_alias)
    ItemAlias.first_or_create(:alias => some_alias, :item => self)
  end

  def has_alias(some_alias)
    ItemAlias.first(:alias => some_alias, :item => self) != nil
  end

  def remove_alias(some_alias)
    some_alias = ItemAlias.first(:alias => some_alias, :item => self)
    some_alias.destroy if some_alias
  end
end