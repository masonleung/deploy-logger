require 'rubygems'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra'

get '/health/' do
    'OK'
end
