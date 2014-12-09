require "./server"
run Sinatra::Application

set :bind, '0.0.0.0'

YAML::load_file(File.join(__dir__, '/config/database.yml'))[env].symbolize_keys.each do |k, v|
    set k, v
end

ActiveRecord::Base.establish_connection(
    adapter: "mysql2", 
    host: settings.db_host,
    database: settings.db_name,
    username: settings.db_username,
    password: settings.db_password) 
)

