# frozen_string_literal: true

# Base class for Service Objects
# Shared attributes should be added
# to this class
class BaseService
  attr_reader :registry_namespace, :location_channel

  def initialize
    @registry_namespace = ENV['VEHICLE_REGISTRY_REDIS_NAMESPACE'] || 'registry'
    @location_namespace = ENV['LOCATION_REGISTRY_REDIS_NAMESPACE'] || 'location'
    @location_channel = ENV['VEHICLE_LOCATION_REDIS_CHANNEL'] || 'locations'
  end

  def redis_url
    ENV['REDIS_URL'] || ENV['REDIS_URL_DEV']
  end
end
