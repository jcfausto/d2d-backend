# frozen_string_literal: true

# Base class for Service Objects
# Shared attributes should be added
# to this class
class BaseService
  attr_reader :registry_namespace

  def initialize
    @registry_namespace = ENV['VEHICLE_REGISTRY_REDIS_NAMESPACE'] || 'registry'
  end
end
