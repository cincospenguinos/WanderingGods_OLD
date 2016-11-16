require 'test/unit'
require 'dm-mysql-adapter'
require_relative '../../app/models/dungeon'

class DungeonTest < Test::Unit::TestCase

  def setup
    DataMapper.setup(:default, 'mysql://gods:some_pass@localhost/WanderingGods')
    DataMapper.finalize
    DataMapper.auto_migrate!
  end


  def teardown
    Dungeon.all.destroy!
  end

  def test_constructor
    dungeon = Dungeon.create!(:name => 'A Dungeon')
  end
end