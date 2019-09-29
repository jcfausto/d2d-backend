# frozen_string_literal: true

require 'time'
require 'json'

# Model representing a vehicle location notification
# params:
#   @vehicle: Instance of Vehicle
#   @location: Instance of Location
#   @notification_time: DateTime
#   @bearing: Bearing
class LocationNotification
  attr_reader :vehicle, :location, :notification_time, :bearing

  def initialize(params = {})
    validate_params(params)
    @city_manager = params[:city_manager]
    @vehicle = params[:vehicle]
    @location = params[:location]
    @notification_time = params[:notification_time]
    set_bearing!(@location)
  end

  def as_json
    hash = {}
    hash[:lat] = @location.lat
    hash[:lng] = @location.lng
    hash[:bearing] = @bearing.value
    hash[:at] = @notification_time
    hash[:vehicle_id] = @vehicle.uuid
    hash.to_json
  end

  private

  # Sets the @bearing based on the location
  def set_bearing!(location)
    @bearing = GeoCalc.bearing_between(@city_manager.central_point, location)
  end

  def validate_params(params)
    validate_required_params(params)
    validate_param_types(params)
    validate_city_manager_present(params)
  end

  def validate_required_params(params)
    raise_invalid_param unless params.keys.include? :vehicle
    raise_invalid_param unless params.keys.include? :location
    raise_invalid_param unless params.keys.include? :notification_time
  end

  def validate_param_types(params)
    raise_invalid_param unless params[:vehicle].is_a? Vehicle
    raise_invalid_param unless params[:location].is_a? Location
    raise_invalid_param unless params[:notification_time].is_a? String
    begin
      Time.iso8601(params[:notification_time])
    rescue ArgumentError
      raise_invalid_param
    end
  end

  def validate_city_manager_present(params)
    raise_invalid_param unless params.keys.include? :city_manager
    raise_invalid_param unless params[:city_manager].is_a? CityManager
  end

  def raise_invalid_param
    raise ArgumentError, 'Invalid params'
  end
end
