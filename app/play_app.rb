require 'sinatra/base'
require 'data_mapper'
require 'json'

require_relative 'models/direction'
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
      dungeon = Dungeon.first(:id => 1) # TODO: Better way of grabbing this?
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
    if @params.size == 0
      send_response(true, get_player.look)
    elsif @params.size == 1
      item_name = @params['0'].downcase
      resp = get_player.look_at(item_name)

      if resp
        send_response(true, resp.sub("\n", "<br/>"))
      else
        send_response(false, "I don't see anything called \"#{item_name}\"")
      end

    else
      send_response(false, 'Usage: "look" or "look [item]"')
    end
  end

  post '/go' do
    if @params.size != 1
      send_response(false, 'Where do you want to go?')
    else
      direction = @params['0']
      resp = get_player.go(direction)

      if resp
        send_response(true, resp)
      else
        send_response(false, 'You can\'t go that direction.')
      end
    end
  end

  post '/exits' do
    # TODO: This
    send_response(false, 'This still needs to be done.')
  end

  post '/help' do
    if @params.size == 0
      resp = '<strong>look [object]</strong> - look at the room or an object<br/>'\
      '<strong>exits</strong> - displays the current exists you may take'\
      '<strong>help [command]</strong> - display this menu or see more information about a command<br/>'

      send_response(true, resp)
    elsif @params.size == 1
      send_response(true, 'This part coming soon... maybe...')
    else
      send_response(false, 'Usage: "help" or "help [command]"')
    end
  end

  post '/*' do
    send_response(false, "I'm afraid I do not understand. Use the \"help\" command for help.")
  end
end