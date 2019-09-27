# frozen_string_literal: true

require 'redis'
require 'json'
require 'logger'
require_relative 'services/storage_service'

# Consumes published messages and store them
# on permanent storage
class StorageConsumer
  def initialize
    @redis = Redis.new
    @channel = ENV['VEHICLE_LOCATION_REDIS_CHANNEL'] || 'locations'
    @log = Logger.new(STDOUT)
  end

  def start
    subscribe
  rescue Redis::BaseConnectionError => e
    @log.info "#{e}, retrying in 5 seconds"
    sleep 5
    retry
  end

  private

  def subscribe
    @redis.subscribe(@channel) do |on|
      @log.info "Subscribed to channel ##{@channel}"
      on.message do |_channel, msg|
        @log.debug msg
        StorageService.new.call(msg)
      end
    end
  end
end
