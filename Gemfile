# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.6.3'

gem 'grape'
gem 'grape-entity'
gem 'grape-swagger'
gem 'puma'
gem 'rack'
gem 'redis', '>= 3.2.0'
gem 'require_all'

group :development do
  gem 'rubocop', '~> 0.74.0', require: false
end

group :test do
  gem 'mock_redis'
  gem 'rack-test'
  gem 'rspec'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'pry-byebug'
end
