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

  belongs_to :player, :required => false

  def add_room(room)
    self.dungeon_graph[room.id.to_s] = {}
  end

  def has_room(room)
    # puts "Graph: #{self.dungeon_graph}\tRoom ID: #{room.id}\tExists: #{self.dungeon_graph[room.id.to_s]}"
    self.dungeon_graph[room.id.to_s] != nil
  end

  def remove_room(room)
    self.dungeon_graph[room.id.to_s] = nil if has_room(room)

    self.dungeon_graph.each do |k, v|
      next unless v

      v.each do |direction, r|
        v[direction] = nil if r.to_s == room.id.to_s
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

    self.dungeon_graph[origin.id.to_s][direction] = destination.id
    save
  end

  def has_exit_in_direction(room, direction)
    return false unless has_room(room)
    self.dungeon_graph[room.id.to_s][direction] != nil
  end

  def has_connection(room1, room2)
    return false unless has_room(room1) && has_room(room2)

    self.dungeon_graph[room1.id.to_s].each do |direction, id|
      return true if room2.id.to_s == id.to_s
    end

    self.dungeon_graph[room2.id.to_s].each do |direction, id|
      return true if room1.id.to_s == id.to_s
    end

    false
  end

  def go(origin, direction)
    return nil unless has_exit_in_direction(origin, direction)
    Room.first(:id => self.dungeon_graph[origin.id.to_s][direction])
  end

  def exits_strings(room)
    exits = []
    # puts has_room(room)
    return exits unless has_room(room)
    self.dungeon_graph[room.id.to_s].each do |k|
      k.each do |i|
        exits += [Direction.to_s(i.to_i)]
      end
    end

    exits.each do |i|
      raise RuntimeError, 'An exit returned as nil' if i.nil?
    end

    exits
  end
end