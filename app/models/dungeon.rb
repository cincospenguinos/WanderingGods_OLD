require 'data_mapper'

require_relative 'direction'
require_relative 'room'

class Dungeon
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true
  property :author, String, :required => true

  property :connections, Json, :default => {}
  property :first_room, String # TODO: Convert this into an ID instead, as there may be multiple rooms with the same name

  # TODO: Dungeons with rooms with the same name? Switch to IDs instead?
  has n, :rooms # TODO: Maybe just JSON property instead?

  belongs_to :player, :required => false

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

  def get_first_room
    raise RuntimeError, 'There is no first room for this dungeon' unless self.first_room
    Room.first(:name => self.first_room, :dungeon => self)
  end

  def set_first_room(room)
    update(:first_room => room.name)
    add_room(room) unless has_room(room.name)
  end

  def connect_rooms(origin, destination, direction)
    return unless has_room(origin.name) && has_room(destination.name)
    return unless Direction.is_direction?(direction)

    self.connections[origin.name][direction] = destination.name
  end

  def has_exit_in_direction(room, direction)
    return false unless has_room(room.name)
    herp = self.connections
    self.connections[room.name][direction] != nil
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

  def get_room_through_direction(room, direction)
    return nil unless has_exit_in_direction(room, direction)
    Room.first(:name => self.connections[room.name][direction])
  end
end