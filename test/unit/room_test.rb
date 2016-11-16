require 'test/unit'

require_relative '../../app/models/room'
require_relative '../../app/models/item'

class RoomTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # DataMapper::Logger.new($stdout, :debug)
    DataMapper::Model.raise_on_save_failure = true
    DataMapper.setup(:default, 'mysql://gods:some_pass@localhost/WanderingGods')
    DataMapper.finalize
    DataMapper.auto_migrate!
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    ItemAlias.all.destroy!
    Item.all.destroy!
    Room.all.destroy!
  end

  def test_constructor
    room = Room.create(:name => 'Some Room')
  end

  def test_add_item
    room = Room.create!(:name => 'Some Room')
    item = Item.create!(:name => 'Item', :description => 'An item')
    room.add_item(item)
    assert(room.has_item(item.name))
  end
end