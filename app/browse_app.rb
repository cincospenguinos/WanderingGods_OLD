require 'sinatra/base'

class BrowseApp < Sinatra::Base

  get '/' do
    'Hello from browse app!'
  end
end