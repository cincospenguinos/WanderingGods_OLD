require 'test/unit'

require_relative '../../app/models/item'
require_relative '../../app/models/room'

class ItemTest < Test::Unit::TestCase

  def setup
    DataMapper.setup(:default, 'mysql://gods:some_pass@localhost/WanderingGods')
    DataMapper::Model.raise_on_save_failure = true
    DataMapper.finalize
    DataMapper.auto_migrate!
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    ItemAlias.all.destroy!
    Item.all.destroy!
  end

  def test_constructor
    Item.create(:name => 'Herp', :description => 'Some description')
  end

  def test_add_alias
    item = Item.create(:name => 'Item', :description => 'Some description')
    item.add_alias('something')
    assert(item.has_alias('something'))
  end

  def test_remove_alias
    item = Item.create(:name => 'Item', :description => 'Some description')
    item.add_alias('something')
    assert(item.has_alias('something'))
    item.remove_alias('something')
    assert(!item.has_alias('something'))
  end
end