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
    location = @location_notification.location.coordinates
    begin
      redis = Redis.new(url: redis_url)
      redis.set("#{@location_namespace}:#{vehicle_id}", location)
    ensure
      redis.close
    end
  end

  def publish
    message = @location_notification.as_json
    begin
      redis = Redis.new(url: redis_url)
      redis.publish(location_channel, message)
    ensure
      redis.close
    end
  end

  def valid?
    location = @location_notification.location
    @city_manager.valid_location?(location)
  end

  def last_valid_location(vehicle_id)
    redis_query = "#{@location_namespace}:#{vehicle_id}"
    begin
      redis = Redis.new(url: redis_url)
      location = redis.get(redis_query)
    ensure
      redis.close
    end
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
