# frozen_string_literal: true

require 'redis'
require 'json'
require 'logger'
require_relative 'services/storage_service'

# Consumes published messages and store them
# on permanent storage
class StorageConsumer
  def initialize
    @log = Logger.new(STDOUT)
    redis_url = ENV['REDIS_URL'] || ENV['REDIS_URL_DEV']
    @log.debug "Redis URL: #{redis_url}"
    @redis = Redis.new(url: redis_url)
    @channel = ENV['VEHICLE_LOCATION_REDIS_CHANNEL'] || 'locations'
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
      on.message do |_channel, message|
        @log.debug message
        StorageService.new.call(message)
      end
    end
  end
end
