# frozen_string_literal: true

# Service Object responsible for
# de-registering vehicles
class DeRegisterService < BaseService
  def call(vehicle_id)
    redis = Redis.new(url: redis_url)
    redis.del("#{registry_namespace}:#{vehicle_id}")
  ensure
    redis.close
  end
end
