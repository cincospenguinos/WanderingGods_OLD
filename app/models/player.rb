# player.rb
#
# Class representing a player
require 'data_mapper'

class Player
  include DataMapper::Resource

  ## User information
  property :id, Serial
  property :username, String, :required => true
  property :salt, String, :required => true
  property :hashword, String, :required => true
  property :email_address, String, :required => true

  ## Player information
  property :str, Integer, :required => true
  property :con, Integer, :required => true
  property :dex, Integer, :required => true
  property :int, Integer, :required => true

  property :current_health, Integer, :required => true

end