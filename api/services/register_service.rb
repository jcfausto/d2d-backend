# frozen_string_literal: true

# Service Object responsible for registering
# a vehicle
class RegisterService
  def call(vehicle_id)
    Redis.current.set(vehicle_id, true)
  end
end
