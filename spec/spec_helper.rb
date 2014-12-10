require 'bundler'
Bundler.require
require 'rack/test'
require 'rspec'
require 'factory_girl'
require File.expand_path '../../app.rb', __FILE__
require File.expand_path '../../models/deploy_log.rb', __FILE__



ENV['RACK_ENV'] = 'test'

FactoryGirl.definition_file_paths = [File.expand_path('../factories', __FILE__)]
FactoryGirl.find_definitions

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # supporst Sinatra REST API
  config.include Rack::Test::Methods

  # mock model with factory girl
  config.include FactoryGirl::Syntax::Methods

end
