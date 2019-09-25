# frozen_string_literal: true

# Service Object responsible for
# de-registering vehicles
class DeRegisterService
  def call(vehicle_id)
    Redis.current.del(vehicle_id)
  end
end
