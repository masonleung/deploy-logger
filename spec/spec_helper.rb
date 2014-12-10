require 'rack/test'
require 'rspec'
require 'database_cleaner'
require 'factory_girl'

require File.expand_path '../../app.rb', __FILE__
require File.expand_path '../../models/deploy_log.rb', __FILE__

ENV['RACK_ENV'] ||= 'test'


FactoryGirl.definition_file_paths = [File.expand_path('../factories', __FILE__)]
FactoryGirl.find_definitions

ActiveRecord::Base.logger.level = 1

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

  config.before(:suite) do
    DatabaseCleaner.clean_with(:deletion)
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
