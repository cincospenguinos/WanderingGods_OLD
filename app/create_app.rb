require 'sinatra/base'

class CreateApp < Sinatra::Base

  get '/' do
    'Hello from create app!'
  end
end