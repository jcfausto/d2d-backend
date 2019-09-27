# frozen_string_literal: true

require File.expand_path('../config/environment', __dir__)

require 'redis'
require 'json'

# Consumes published messages and store them
# on permanent storage
class StorageConsumer
  def initialize
    @redis = Redis.new
    @channel = ENV['VEHICLE_LOCATION_REDIS_CHANNEL'] || 'locations'
  end

  def start
    subscribe
  rescue Redis::BaseConnectionError => e
    debug "#{e}, retrying in 5 seconds"
    sleep 5
    retry
  end

  private

  def subscribe
    @redis.subscribe(@channel) do |on|
      puts "Subscribed to channel ##{@channel}"
      on.message do |_channel, msg|
        StorageService.new.call(msg)
      end
    end
  end
end
