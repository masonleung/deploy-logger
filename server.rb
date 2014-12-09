require 'rubygems'
require 'sinatra/base'
# require 'sinatra/activerecord'

get '/health/' do
    'OK'
end
