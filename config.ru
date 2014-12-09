require "rubygems"
require "sinatra"

require File.expand_path '../server.rb', __FILE__

set :bind, '0.0.0.0'

run Sinatra::Application
