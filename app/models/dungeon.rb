require 'data_mapper'

require_relative 'direction'
require_relative 'room'

class Dungeon
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true
  property :author, String, :required => true

  property :dungeon_graph, Json, :default => {}
  property :first_room_id, Integer

  # TODO: Dungeons with rooms with the same name? Switch to IDs instead?
  # has n, :rooms # TODO: Maybe just JSON property instead?

  belongs_to :player, :required => false

  def add_room(room)
    # room.update(:dungeon => self)
    # self.connections[room.name] = {}
    self.dungeon_graph[room.id] = {}
  end

  def has_room(room)
    # Room.first(:name => room_name, :dungeon => self) != nil
    self.dungeon_graph[room.id] != nil
  end

  def remove_room(room)
    # room = Room.first(:name => room_name, :dungeon => self)
    #
    # if room
    #   room.update(:dungeon => nil)
    #
    #   # TODO: Manage all of the connections
    #
    #   self.connections[room.name] = nil
    # end
    self.dungeon_graph[room.id] = nil if self.dungeon_graph[room.id]

    self.dungeon_graph.each do |k, v|
      next unless v

      v.each do |direction, r|
        v[direction] = nil if r == room.id
      end
    end
  end

  def get_first_room
    raise RuntimeError, 'There is no first room for this dungeon' unless self.first_room_id
    Room.first(:id => self.first_room_id)
  end

  def set_first_room(room)
    save if dirty?
    update(:first_room_id => room.id)
    add_room(room) unless has_room(room)
  end

  def connect_rooms(origin, destination, direction)
    return unless has_room(origin) && has_room(destination)
    return unless Direction.is_direction?(direction)

    self.dungeon_graph[origin.id][direction] = destination.id
    save
  end

  def has_exit_in_direction(room, direction)
    return false unless has_room(room)
    self.dungeon_graph[room.id][direction] != nil
  end

  def has_connection(room1, room2)
    return false unless has_room(room1) && has_room(room2)

    self.dungeon_graph[room1.id].each do |direction, id|
      return true if room2.id == id
    end

    self.dungeon_graph[room2.id].each do |direction, id|
      return true if room1.id == id
    end

    false
  end

  # TODO: Rename this
  def get_room_through_direction(room, direction)
    return nil unless has_exit_in_direction(room, direction)
    Room.first(:name => self.dungeon_graph[room.id][direction])
  end
end