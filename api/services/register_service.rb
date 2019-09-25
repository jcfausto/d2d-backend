# frozen_string_literal: true

# Service Object responsible for registering
# a vehicle
class RegisterService < BaseService
  def call(vehicle_id)
    Redis.current.set("#{registry_namespace}:#{vehicle_id}", true)
  end
end
