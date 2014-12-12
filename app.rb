require 'sinatra'
require 'sinatra/activerecord'
require 'pry'
require 'pry-nav'
require 'sinatra/contrib'

set :bind, '0.0.0.0'

before /.*/ do
    if request.url.match(/.json$/)
        request.accept.unshift('application/json')
        request.path_info = request.path_info.gsub(/.json$/, '')
    end
end

def render_response deploy_logs
    respond_to do |format|
        format.json { deploy_logs.to_json }
        format.html { erb :index, :locals => { :deploy_logs => deploy_logs} }
    end
end

get '/health' do
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
    DeployLog.new(deployer: deployer, tag: tag, application: application, environment: environment).save
    status 200
    body 'added'
end

get '/api/deploy/log', :provides => [:html, :json] do
    deploy_log_ids = DeployLog.select("max(id) as id").group(:application, :environment).collect(&:id)
    deploy_logs = DeployLog.order(:application, :environment).where(:id => deploy_log_ids)
    render_response deploy_logs
end

get '/api/deploy/log/staging', :provides => [:html, :json] do
    deploy_log_ids = DeployLog.select("max(id) as id").where(:environment => 'staging').group(:application, :environment).collect(&:id)
    deploy_logs = DeployLog.order(:application, :environment).where(:id => deploy_log_ids)
    render_response deploy_logs
end

get '/api/deploy/log/production', :provides => [:html, :json] do
    deploy_log_ids = DeployLog.select("max(id) as id").where(:environment => 'production').group(:application, :environment).collect(&:id)
    deploy_logs = DeployLog.order(:application, :environment).where(:id => deploy_log_ids)
    render_response deploy_logs
end

get '/api/deploy/log/recent', :provides => [:html, :json] do
    deploy_logs = DeployLog.order(:id).limit(50)
    render_response deploy_logs
end
