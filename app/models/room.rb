require 'data_mapper'

class Room
  include DataMapper::Resource

  property :id, Serial
  property :name, String


  def add_item(item)
    # TODO: This
  end

  def has_item(item_name)
    # TODO: This
  end

  def take_item(item_name)
    # TODO: This
  end
end