# player.rb
#
# Class representing a player
require 'data_mapper'
require_relative 'item'

class Player
  include DataMapper::Resource

  ## User information
  property :id, Serial
  property :username, String, :required => true
  # property :salt, String, :required => true
  # property :hashword, String, :required => true
  # property :email_address, String, :required => true

  ## Player information
  property :str, Integer, :required => true
  property :con, Integer, :required => true
  property :dex, Integer, :required => true
  property :int, Integer, :required => true

  property :current_health, Integer

  has n, :items
  has 1, :dungeon
  has 1, :room

  before :create do
    self.current_health = max_health
  end

  def physical_to_hit
    self.dex
  end

  def physical_damage
    (self.str / 2).to_i
  end

  def spell_to_hit
    self.con
  end

  def spell_damage
    (self.int / 2).to_i
  end

  def evasiveness
    5 + (self.dex + 2 * self.int / 3).to_i
  end

  def max_health
    ((self.str + self.con) / 2).to_i
  end

end