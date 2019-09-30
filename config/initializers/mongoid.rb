# frozen_string_literal: true

require 'mongoid'

if ENV['MONGODB_URI']
  ENV['MONGODB_URI'] = "#{ENV['MONGODB_URI']}?retryWrites=false"
end

# Mongoid configuration
Mongoid.load!(File.expand_path('mongoid.yml', './config'), ENV['RACK_ENV'])
