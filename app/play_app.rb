require 'sinatra/base'
require 'data_mapper'
require 'json'

require_relative 'models/player'

class PlayApp < Sinatra::Base

  # TODO: Sessions!

  helpers do
    def send_response(successful, message)
      data = {}
      data[:successful] = successful
      data[:message] = message
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
    send_response(false, "I'm afraid I do not understand. Use the \"help\" command for help.")
  end
end