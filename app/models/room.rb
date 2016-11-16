require 'data_mapper'
require_relative 'item'

class Room
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true
  has n, :items


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

  def take_item(item_name)
    item = Item.first(:name => item_name, :room => self)
    item.update(:room => nil) if item
    item
  end
end