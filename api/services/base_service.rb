# frozen_string_literal: true

# Base class for Service Objects
# Shared attributes should be added
# to this class
class BaseService
  attr_reader :registry_namespace, :location_channel

  def initialize
    @registry_namespace = ENV['VEHICLE_REGISTRY_REDIS_NAMESPACE'] || 'registry'
    @location_channel = ENV['VEHICLE_LOCATION_REDIS_CHANNEL'] || 'locations'
  end
end
