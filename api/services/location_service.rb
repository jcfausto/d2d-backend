# frozen_string_literal: true

# Service Object responsible for publishing
# vehicle location updates
class LocationService < BaseService
  def call(params)
    build_location_notification!(params)
    return unless valid?

    register_last_valid_location
    publish
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

  def register_last_valid_location
    vehicle_id = @location_notification.vehicle.uuid
    location = [
      @location_notification.location.lat,
      @location_notification.location.lng
    ]
    Redis.new(url: redis_url).set("#{@location_namespace}:#{vehicle_id}",
                                  location)
  end

  def publish
    message = @location_notification.as_json
    Redis.new(url: redis_url).publish(location_channel, message)
  end

  def valid?
    location = @location_notification.location
    @city_manager.valid_location?(location)
  end

  def last_valid_location(vehicle_id)
    redis_query = "#{@location_namespace}:#{vehicle_id}"
    location = Redis.new(url: redis_url).get(redis_query)
    return unless location

    location = JSON.parse(location)
    Location.new(location[0], location[1])
  end

  def hash_params(params)
    current_location = Location.new(params[:lat], params[:lng])
    hash = {}
    hash[:vehicle] = Vehicle.new(params[:id])
    hash[:location] = current_location
    hash[:last_location] = last_valid_location(params[:id]) || current_location
    hash[:notification_time] = params[:at].to_s
    hash[:city_manager] = @city_manager
    hash
  end
end
