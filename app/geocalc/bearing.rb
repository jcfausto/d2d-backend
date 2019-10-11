# frozen_string_literal: true

# Geo calculations.
# Calculate the navigation bearing
# Arguments:
#   reference_point, current_point: Location
# Note: partially extracted from geocoder gem
#       partially implemented by myself
module GeoCalc
  def self.bearing_between(reference_point, current_point)
    # Coordinates
    point_one_lat = reference_point.lat
    point_one_lng = reference_point.lng

    point_two_lat = current_point.lat
    point_two_lng = current_point.lng

    # Formula expect values in radians
    lat1x = point_one_lat * GeoCalc::Constants::RAD
    lon1x = point_one_lng * GeoCalc::Constants::RAD
    lat2x = point_two_lat * GeoCalc::Constants::RAD
    lon2x = point_two_lng * GeoCalc::Constants::RAD

    # Deltas values are radians as required
    # by the formula
    dlon = lon2x - lon1x

    y = Math.sin(dlon) * Math.cos(lat2x)
    x = Math.cos(lat1x) * Math.sin(lat2x) -
        Math.sin(lat1x) * Math.cos(lat2x) * Math.cos(dlon)

    bearing = Math.atan2(x, y)
    # Answer is given in radians counterclockwise from due east.
    # Convert to degrees clockwise from due north as per the
    # navigation bearing definition
    # https://en.wikipedia.org/wiki/Bearing_(navigation)
    result = (90 - ((bearing * 180.0) / Math::PI) + 360) % 360

    Bearing.new(result)
  end
end
