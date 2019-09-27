# frozen_string_literal: true

require 'mongoid'

# Mongoid configuration
Mongoid.load!(File.expand_path('mongoid.yml', './config'), ENV['RACK_ENV'])
