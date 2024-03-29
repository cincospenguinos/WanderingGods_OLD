require 'test/unit'

require_relative '../../app/models/item'
require_relative '../../app/models/room'
require_relative '../../app/models/dungeon'
require_relative '../../app/models/player'

class PlayerTest < Test::Unit::TestCase

  def setup
    DataMapper::Model.raise_on_save_failure = true
    DataMapper.setup(:default, 'mysql://gods:some_pass@localhost/WanderingGods_dev')
    DataMapper.finalize
    DataMapper.auto_migrate!
  end

  def teardown
    Room.all.destroy!
    Dungeon.all.destroy!
    Player.all.destroy!
  end

  def test_constructor
    Player.create(:username => 'a', :str => 1, :con => 3, :dex => 10, :int => 6)
  end

  def test_enter_dungeon
    player = Player.create(:username => 'a', :str => 1, :con => 3, :dex => 10, :int => 6)
    room = Room.create(:name => 'Some room', :description => 'A room')
    dungeon = Dungeon.create(:name => 'Some Dungeon', :author => 'Me')
    dungeon.set_first_room(room)
    player.enter_dungeon(dungeon)

    first_room = player.get_current_room

    assert_true(first_room.name == 'Some room')
    assert_true(first_room.description == 'A room')
  end

  def test_look
    player = Player.create(:username => 'a', :str => 1, :con => 3, :dex => 10, :int => 6)
    room = Room.create(:name => 'Some room', :description => 'A room')
    dungeon = Dungeon.create(:name => 'Some Dungeon', :author => 'Me')
    dungeon.set_first_room(room)
    player.enter_dungeon(dungeon)

    look = player.look.sub("\n", '')

    assert_true(look == room.description)
  end

  def test_go
    player = Player.create(:username => 'a', :str => 1, :con => 3, :dex => 10, :int => 6)
    room = Room.create(:name => 'Some room', :description => 'A room')
    other_room = Room.create(:name => 'Different room', :description => 'A different room')
    dungeon = Dungeon.create(:name => 'Some Dungeon', :author => 'Me')
    dungeon.set_first_room(room)
    dungeon.add_room(other_room)
    dungeon.connect_rooms(room, other_room, Direction::WEST)
    dungeon.connect_rooms(other_room, room, Direction::EAST)
    player.enter_dungeon(dungeon)

    assert_true(player.go(Direction::WEST))
    assert_true(player.get_current_room.name == other_room.name)
    assert_true(player.go(Direction::EAST))
    assert_true(player.get_current_room.name == room.name)
  end
end