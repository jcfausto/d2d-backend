# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'
require File.expand_path('../config/initializers/mongoid', __dir__)

require 'dotenv'
Dotenv.load(File.expand_path("../.env.#{ENV['RACK_ENV']}", __dir__))

require_relative 'streaming_server'

trap('INT') do
  puts
  puts 'Exiting, bye!'
  exit
end

StreamingServer.new.start if ARGV && ARGV[0] == 'start'
