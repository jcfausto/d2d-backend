# frozen_string_literal: true

# Service Object responsible for
# de-registering vehicles
class DeRegisterService < BaseService
  def call(vehicle_id)
    redis_url = ENV['REDIS_URL'] || ENV['REDIS_URL_DEV']
    Redis.new(url: redis_url).del("#{registry_namespace}:#{vehicle_id}")
  end
end
