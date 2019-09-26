# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

if ENV['RUN_COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

require File.expand_path('../config/environment', __dir__)

require 'rspec'
require 'shoulda-matchers'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
  end
end

RSpec.configure do |config|
  config.include Rack::Test::Methods, api: true

  config.before(:each) do
    mock_redis = MockRedis.new
    allow(Redis).to receive(:new).and_return(mock_redis)
  end
end
