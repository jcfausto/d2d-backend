# frozen_string_literal: true

# Service Object responsible for publishing
# vehicle location updates
class LocationService < BaseService
  def call(params)
    build_location_notification!(params)
    publish if valid?
  end

  def initialize
    super
    @city_manager = CityManager.new
  end

  private

  def build_location_notification!(params)
    hash = hash_params(params)
    @location_notification = LocationNotification.new(hash)
  end

  def publish
    message = @location_notification.as_json
    Redis.current.publish(location_channel, message)
  end

  def valid?
    location = @location_notification.location
    @city_manager.valid_location?(location)
  end

  def hash_params(params)
    hash = {}
    hash[:vehicle] = Vehicle.new(params[:id])
    hash[:location] = Location.new(params[:lat], params[:lng])
    hash[:notification_time] = params[:at].to_s
    hash
  end
end
