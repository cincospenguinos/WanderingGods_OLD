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

  # TODO: Change this so that it gets fixed after create
  property :current_health, Integer, :required => true

  # has_n :items
  # has 1, :dungeon

  after :create do

  end

  # TODO: Get all the other stats up

end