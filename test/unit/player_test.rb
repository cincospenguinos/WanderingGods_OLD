require 'test/unit'

require_relative '../../app/models/player'

class PlayerTest < Test::Unit::TestCase

  def setup
    DataMapper::Model.raise_on_save_failure = true
    DataMapper.setup(:default, 'mysql://gods:some_pass@localhost/WanderingGods')
    DataMapper.finalize
    DataMapper.auto_migrate!
  end

  def teardown
    Player.all.destroy!
    Room.all.destroy!
    Dungeon.all.destroy!
  end

  def test_constructor
    Player.create(:username => 'a', :str => 1, :con => 3, :dex => 10, :int => 6)
  end
end