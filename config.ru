require_relative 'app/play_app'
require_relative 'app/create_app'
require_relative 'app/browse_app'

map('/') { run PlayApp }
map('/create') { run CreateApp }
map('/browse') { run BrowseApp }