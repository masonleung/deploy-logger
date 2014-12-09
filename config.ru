require "rubygems"
require "sinatra"

require File.expand_path '../app.rb', __FILE__

ENV['RACK_ENV'] ||= 'development'

set :bind, '0.0.0.0'

run Sinatra::Application
