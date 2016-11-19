require 'sinatra/base'
require 'data_mapper'
require 'json'

require_relative 'models/item_alias'
require_relative 'models/item'
require_relative 'models/monster'
require_relative 'models/room'
require_relative 'models/dungeon'
require_relative 'models/player'

class PlayApp < Sinatra::Base

  enable :sessions

  helpers do
    def get_player
      Player.first(:id => session[:player_id])
    end

    def generate_random_player
      player = Player.create(:username => 'guest', :str => 5, :con => 5, :dex => 5, :int => 5)

      # TODO: Better way to put together the tutorial dungeon? Perhaps just pulling it up from the DB?
      dungeon = Dungeon.create(:name => 'Eden')
      room = Room.create(:name => 'House', :description => 'You are standing in front of a white house.')
      dungeon.set_first_room(room)
      player.enter_dungeon(dungeon)

      player.id
    end

    def send_response(successful, description)
      data = {}
      data[:successful] = successful
      data[:room] = get_player.get_current_room.name
      data[:description] = description
      data.to_json
    end
  end

  get '/' do
    session[:player_id] = generate_random_player unless session[:player_id]
    erb :play_index
  end

  post '/look' do
    send_response(true, get_player.look)
  end

  post '/*' do
    send_response(false, "I'm afraid I do not understand. Use the \"help\" command for help.")
  end
end