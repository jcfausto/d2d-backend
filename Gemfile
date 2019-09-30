# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.6.3'

gem 'dotenv'
gem 'em-hiredis'
gem 'em-websocket'
gem 'eventmachine'
gem 'grape'
gem 'grape-entity'
gem 'grape-swagger'
gem 'logger'
gem 'mongoid'
gem 'puma'
gem 'rack'
gem 'redis', '>= 3.2.0'
gem 'require_all'

gem 'em-http-request'
gem 'faye-websocket'
gem 'sinatra'
gem 'thin'

group :development do
  gem 'rubocop', '~> 0.74.0', require: false
end

group :test do
  gem 'database_cleaner'
  gem 'json-schema'
  gem 'mongoid-rspec'
  gem 'rack-test'
  gem 'rspec'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'pry-byebug'
end
