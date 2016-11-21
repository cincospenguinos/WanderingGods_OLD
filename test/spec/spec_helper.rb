require 'rack/test'
require 'rspec'
require 'data_mapper'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../../app/play_app', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() described_class end
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include RSpecMixin
end