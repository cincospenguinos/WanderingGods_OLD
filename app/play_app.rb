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

  # TODO: Sessions!

  helpers do
    def send_response(successful, room, description)
      data = {}
      data[:successful] = successful
      data[:room] = room
      data[:description] = description
      data.to_json
    end
  end

  get '/' do
    erb :play_index
  end

  post '/look' do
    # TODO: Look command here
  end

  post '/*' do
    # TODO: Return current room
    send_response(false, "Some Room", "I'm afraid I do not understand. Use the \"help\" command for help.")
  end
end