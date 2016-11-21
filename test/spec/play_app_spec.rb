require File.expand_path '../spec_helper', __FILE__
require_relative '../../app/play_app'

describe 'Wandering Gods Gameplay' do

  before(:all) do
    get '/'
  end

  it 'returns the proper exits' do
    get '/exits'
  end
end