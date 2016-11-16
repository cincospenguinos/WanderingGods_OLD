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
    # TODO: Figure out downcase/upcase situation, and look at aliases
    false if Item.first(:name => item_name,  :room => self) == nil
    true
  end

  def take_item(item_name)
    # TODO: This
  end
end