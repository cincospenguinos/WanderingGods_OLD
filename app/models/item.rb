require 'data_mapper'

require_relative 'item_alias'

class Item
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true
  property :description, Text, :required => true

  has n, :item_aliases # TODO: Convert these into simple JSON elements

  belongs_to :room, :required => false
  belongs_to :player, :required => false

  after :create do |item|
    item.add_alias(item.name)
  end

  def add_alias(some_alias)
    ItemAlias.first_or_create(:alias => some_alias.downcase, :item => self)
  end

  def has_alias(some_alias)
    ItemAlias.first(:alias => some_alias.downcase, :item => self) != nil
  end

  def remove_alias(some_alias)
    some_alias = ItemAlias.first(:alias => some_alias.downcase, :item => self)
    some_alias.destroy if some_alias && some_alias.alias != self.name.downcase
  end
end