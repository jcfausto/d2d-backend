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
end
