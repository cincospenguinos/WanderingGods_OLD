require 'test/unit'

require_relative '../../app/models/room'
require_relative '../../app/models/item'

class RoomTest < Test::Unit::TestCase

  def setup
    DataMapper.setup(:default, 'mysql://gods:some_pass@localhost/WanderingGods_dev')
    DataMapper::Model.raise_on_save_failure = true
    DataMapper.finalize
    DataMapper.auto_migrate!
  end

  def teardown
    ItemAlias.all.destroy!
    Item.all.destroy!
    Room.all.destroy!
  end

  def test_constructor
    room = Room.create(:name => 'Some Room', :description => 'A single room.')
  end

  def test_add_item
    room = Room.create!(:name => 'Some Room', :description => 'Some room.')
    item = Item.create!(:name => 'Item', :description => 'An item')
    room.add_item(item)
    assert(room.has_item(item.name))
  end

  def test_remove_item
    room = Room.create(:name => 'Room', :description => 'Some room')
    item = Item.create(:name => 'item', :description => 'herp')
    room.add_item(item)
    assert_true(room.has_item(item.name))
    room.take_item(item.name)
    assert_false(room.has_item(item.name), 'The room should no longer have the item in it')
  end

  def test_description_with_item
    room = Room.create!(:name => 'Some Room', :description => 'Some room.')
    item = Item.create!(:name => 'Item', :description => 'An item')
    room.add_item(item)

    assert_true(room.get_look_description.include?('There is'))
  end
end