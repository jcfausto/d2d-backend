# frozen_string_literal: true

# Service Object responsible for registering
# a vehicle
class RegisterService < BaseService
  def call(vehicle_id)
    redis_url = ENV['REDIS_URL'] || ENV['REDIS_URL_DEV']
    Redis.new(url: redis_url).set("#{registry_namespace}:#{vehicle_id}", true)
  end
end
