# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'
require 'erb'

require 'dotenv'

Dotenv.load(File.expand_path("../.env.#{ENV['RACK_ENV']}", __dir__))

Bundler.require :default, ENV['RACK_ENV']

require_rel '../lib'
require_rel '../app'
require_rel '../api'
require_rel '../api-consumers'
require_rel '../api-streaming'

require File.expand_path('./initializers/mongoid', __dir__)
