require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'

get '/health/' do
    'OK'
end
