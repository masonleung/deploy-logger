require 'rubygems'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra'
require 'pry'
require 'pry-nav'

get '/health/' do
    'OK'
end

post '/api/deploy/log' do
    deployer = params['deployer']
    tag = params['tag']
    application = params['application']
    environment = params['environment']
    if (deployer.nil? || tag.nil? || application.nil? || environment.nil?)
        halt 404, "missing required parameters"
    end

    DeployLog.create(deployer: deployer, tag: tag, application: application, environment: environment)
    DeployLog.save    
end

get '/api/deploy/log' do
    DeployLog.find(:all, :group => [ :application, :environment])
end

get '/api/deploy/recent' do

end