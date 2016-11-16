require 'test/unit'
require 'dm-mysql-adapter'
require_relative '../../app/models/dungeon'

class DungeonTest < Test::Unit::TestCase

  @db_setup = false

  def startup

  end

  def setup
    unless @db_setup
      DataMapper.setup(:default, 'mysql://gods:some_pass@localhost/WanderingGods')
      DataMapper.finalize
      DataMapper.auto_upgrade!
      @db_setup = true
    end
  end


  def teardown
  end

  def shutdown
    Dungeon.all.destroy!
  end

  def test_constructor
    @dungeon = Dungeon.create!(:name => 'A Dungeon')
  end
end