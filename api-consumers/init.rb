# frozen_string_literal: true

require 'dotenv'

ENV['RACK_ENV'] ||= 'development'
Dotenv.load(File.expand_path("../.env.#{ENV['RACK_ENV']}", __dir__))

require File.expand_path('../config/initializers/mongoid', __dir__)

require_relative 'storage_consumer'

trap('INT') do
  puts
  puts 'Exiting, bye!'
  exit
end

StorageConsumer.new.start if ARGV && ARGV[0] == 'start'
