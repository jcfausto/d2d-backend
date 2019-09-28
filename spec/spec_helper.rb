# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

if ENV['RUN_COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

require File.expand_path('../config/environment', __dir__)

require 'database_cleaner'
require 'json-schema'
require 'mongoid-rspec'
require 'rspec'
require 'shoulda-matchers'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
  end
end

RSpec.configure do |config|
  config.include Rack::Test::Methods, api: true
  config.include Mongoid::Matchers

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = 'mongoid'
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end
end

RSpec::Matchers.define :match_json_schema do |schema|
  match do |json_object|
    schema_directory = "#{Dir.pwd}/spec/support/api/schemas"
    schema_path = "#{schema_directory}/#{schema}.json"
    JSON::Validator.validate!(schema_path, json_object, strict: true)
  end
end
