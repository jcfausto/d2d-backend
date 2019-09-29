# frozen_string_literal: true

# Class representing the city where
# the service is operating and all
# rules related to the operation in
# the city.
#
# By convention, configuration will be
# loaded from a yml file city_manager.yml
# from the ./config directory into a
# @config object.
class CityManager
  attr_reader :config, :central_point

  def initialize
    set_env_if_not_defined
    load_config!
    set_central_point!
  end

  def valid_location?(location)
    valid_param?(location)
    @location = location
    location_within_city_boundaries?
  end

  private

  def location_within_city_boundaries?
    distance_from_central_point <= @config['limit_radius_in_km'].to_f
  end

  def distance_from_central_point
    distance = GeoCalc.distance_between(@central_point, @location)
    distance.in_km
  end

  def set_central_point!
    @central_point = Location.new(@config['central_point']['lat'],
                                  @config['central_point']['lng'])
  end

  def valid_param?(location)
    raise ArgumentError, 'Invalid location param' unless location.is_a? Location
  end

  def load_config!
    city_manager_yml = YAML.load_file(File.join('./config', 'city_manager.yml'))
    @config = city_manager_yml[ENV['RACK_ENV']]
  end

  def set_env_if_not_defined
    ENV['RACK_ENV'] ||= 'development'
  end
end
