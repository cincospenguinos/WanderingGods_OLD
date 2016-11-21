require 'test/unit'
require 'dm-mysql-adapter'

require_relative '../../app/models/player'
require_relative '../../app/models/room'
require_relative '../../app/models/dungeon'

class DungeonTest < Test::Unit::TestCase

  def setup
    DataMapper.setup(:default, 'mysql://gods:some_pass@localhost/WanderingGods_dev')
    DataMapper::Model.raise_on_save_failure = true
    DataMapper.finalize
    DataMapper.auto_migrate!
  end


  def teardown
    Room.all.destroy!
    Dungeon.all.destroy!
  end

  def test_constructor
    dungeon = Dungeon.create(:name => 'A Dungeon', :author => 'Me')
  end

  def test_add_room
    dungeon = Dungeon.create(:name => 'A Dungeon', :author => 'Me')
    room = Room.create(:name => 'Some Room', :description => 'Some room.')
    dungeon.add_room(room)
    assert_true(dungeon.has_room(room))
  end

  def test_connect_rooms
    dungeon = Dungeon.create(:name => 'A Dungeon', :author => 'Me')
    room1 = Room.create(:name => 'Room1', :description => 'Room 1')
    room2 = Room.create(:name => 'Room2', :description => 'Room 2')

    dungeon.add_room(room1)
    dungeon.add_room(room2)

    assert_true(dungeon.has_room(room1))
    assert_true(dungeon.has_room(room2))

    dungeon.connect_rooms(room1, room2, Direction::EAST)
    assert_true(dungeon.has_connection(room1, room2))
  end

  def test_connect_rooms_first_room
    dungeon = Dungeon.create(:name => 'A Dungeon', :author => 'Me')
    room1 = Room.create(:name => 'Room1', :description => 'Room 1')
    room2 = Room.create(:name => 'Room2', :description => 'Room 2')

    dungeon.set_first_room(room1)
    dungeon.add_room(room2)
    dungeon.connect_rooms(room1, room2, Direction::WEST)

    assert_true(dungeon.has_connection(room1, room2))
  end

  def test_unconnected_rooms
    dungeon = Dungeon.create(:name => 'A Dungeon', :author => 'Me')
    room1 = Room.create(:name => 'Room1', :description => 'Room 1')
    room2 = Room.create(:name => 'Room2', :description => 'Room 2')

    dungeon.add_room(room1)
    dungeon.add_room(room2)

    assert_false(dungeon.has_connection(room1, room2))
  end

  def test_remove_room
    dungeon = Dungeon.create(:name => 'A Dungeon', :author => 'Me')
    room1 = Room.create(:name => 'Room1', :description => 'Room 1')

    dungeon.add_room(room1)
    dungeon.remove_room(room1)

    assert_false(dungeon.has_room(room1))
  end

  def test_remove_connected_room1
    dungeon = Dungeon.create(:name => 'A Dungeon', :author => 'Me')
    room1 = Room.create(:name => 'Room1', :description => 'Room 1')
    room2 = Room.create(:name => 'Room2', :description => 'Room 2')

    dungeon.add_room(room1)
    dungeon.add_room(room2)
    dungeon.connect_rooms(room1, room2, Direction::UP)
    dungeon.remove_room(room1)

    assert_false(dungeon.has_room(room1))
    assert_true(dungeon.has_room(room2))
    assert_false(dungeon.has_connection(room1, room2))
  end

  def test_remove_connected_room2
    dungeon = Dungeon.create(:name => 'A Dungeon', :author => 'Me')
    room1 = Room.create(:name => 'Room1', :description => 'Room 1')
    room2 = Room.create(:name => 'Room2', :description => 'Room 2')

    dungeon.add_room(room1)
    dungeon.add_room(room2)
    dungeon.connect_rooms(room1, room2, Direction::SOUTH_EAST)
    dungeon.remove_room(room2)

    assert_false(dungeon.has_room(room2))
    assert_true(dungeon.has_room(room1))
    assert_false(dungeon.has_connection(room1, room2))
  end
end