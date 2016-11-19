require 'data_mapper'
require 'dm-migrations'

require_relative 'app/play_app'
require_relative 'app/create_app'
require_relative 'app/browse_app'

# Setup datamapper bullshilogna
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'mysql://gods:some_pass@localhost/WanderingGods')
DataMapper.finalize
DataMapper.auto_upgrade!

# Setup the routes and point them to the controllers
map('/') { run PlayApp }
map('/create') { run CreateApp }
map('/browse') { run BrowseApp }