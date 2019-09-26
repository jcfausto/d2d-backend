# frozen_string_literal: true

# Service Object responsible for publishing
# vehicle location updates
class LocationService < BaseService
  def call(params)
    location = params.to_json
    Redis.current.publish(location_channel, location)
  end
end
