# frozen_string_literal: true

# Service Object responsible for
# de-registering vehicles
class DeRegisterService < BaseService
  def call(vehicle_id)
    Redis.new(url: redis_url).del("#{registry_namespace}:#{vehicle_id}")
  end
end
