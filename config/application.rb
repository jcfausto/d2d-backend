# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'
require 'erb'

require 'dotenv'
require 'mongoid'

Dotenv.load(File.expand_path("../.env.#{ENV['RACK_ENV']}", __dir__))

Bundler.require :default, ENV['RACK_ENV']

require_rel '../api'
require_rel '../app'
require_rel '../api-consumers'

# Mongoid configuration
Mongoid.load!(File.expand_path('mongoid.yml', './config'), ENV['RACK_ENV'])

# Mongoid.configure do |config|
#   config.clients.default = {
#     hosts: ["#{ENV['MONGODB_HOST']}:#{ENV['MONGODB_PORT']}"],
#     database: ENV['MONGODB_DB_NAME'],
#   }

#   config.log_level = :warn
# end
