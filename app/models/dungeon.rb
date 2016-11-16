require 'data_mapper'

require_relative 'direction'
require_relative 'room'

class Dungeon
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true
  property :connections, Json, :default => {}

  # Rooms are connected via the connections object (a hash) by name. So no dungeon can have two rooms with the same name
  has n, :rooms

  def add_room(room)
    room.update(:dungeon => self)
    self.connections[room.name] = {}
  end

  def has_room(room_name)
    Room.first(:name => room_name, :dungeon => self) != nil
  end

  def remove_room(room_name)
    room = Room.first(:name => room_name, :dungeon => self)

    if room
      room.update(:dungeon => nil)

      # TODO: Manage all of the connections

      self.connections[room.name] = nil
    end
  end

  def connect_rooms(origin, destination, direction)
    return unless has_room(origin.name) && has_room(destination.name)
    return unless Direction.is_direction?(direction)

    self.connections[origin.name][direction] = destination.name
  end

  def has_connection(room1, room2)
    return false unless has_room(room1.name) && has_room(room2.name)

    self.connections[room1.name].each do |direction, name|
      return true if room2.name == name
    end

    self.connections[room2.name].each do |direction, name|
      return true if room1.name == name
    end

    false
  end
end