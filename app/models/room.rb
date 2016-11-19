require 'data_mapper'
require_relative 'item'

class Room
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true
  property :description, Text, :required => true

  has n, :items # TODO: Perhaps consider making these just JSON elements?

  belongs_to :dungeon, :required => false
  belongs_to :player, :required => false


  def add_item(item)
    item.update(:room => item)
  end

  def has_item(item_name)
    return true if Item.first(:name => item_name, :room => self)
    Item.all(:room => self).each do |i|
      return true if i.has_alias(item_name)
    end
    false
  end

  def get_item(item_name)
    item = Item.first(:name => item_name, :room => self)
    return item if item
    Item.all(:room => self).each do |i|
      return i if i.has_alias(itemr_name)
    end
    nil
  end

  def take_item(item_name)
    item = Item.first(:name => item_name, :room => self)
    item.update(:room => nil) if item
    item
  end

  def get_look_description
    desc = ''
    desc += self.description + "\n"

    Item.all(:room => self).each do |i|
      desc += "There is #{i.name.downcase} here.\n"
    end

    desc
  end
end