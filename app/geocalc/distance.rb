# frozen_string_literal: true

# Geo calculations.
# Using the Haversine formula to calculate distances
# Arguments:
#  point_one, point_two, type: Location
# Note: partially extracted from geocoder gem
#       partially implemented by myself
module GeoCalc
  def self.distance_between(point_one, point_two)
    # Coordinates
    point_one_lat = point_one.lat
    point_one_lng = point_one.lng

    point_two_lat = point_two.lat
    point_two_lng = point_two.lng

    # Haversine formula expect values in radians
    point_one_lat *= GeoCalc::Constants::RAD
    point_one_lng *= GeoCalc::Constants::RAD
    point_two_lat *= GeoCalc::Constants::RAD
    point_two_lng *= GeoCalc::Constants::RAD

    # Deltas values are radians as required
    # by the Haversine formula
    delta_lat = point_two_lat - point_one_lat
    delta_lng = point_two_lng - point_one_lng

    # Haversine calculation
    a = Math.sin(delta_lat / 2)**2 + Math.cos(point_one_lat) *
        Math.sin(delta_lng / 2)**2 * Math.cos(point_two_lat)

    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    result = c * GeoCalc::Constants::EARTH_MEAN_RADIUS_IN_METERS

    Distance.new(result)
  end
end
