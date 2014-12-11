require "rubygems"
require "sinatra"

require File.expand_path '../app.rb', __FILE__
require File.expand_path '../models/deploy_log.rb', __FILE__


ENV['RACK_ENV'] ||= 'development'

run Sinatra::Application
