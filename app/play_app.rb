require 'sinatra/base'

class PlayApp < Sinatra::Base

  get '/' do
    erb :play_index
  end
end