# frozen_string_literal: true

module GeoCalc
  module Constants
    # From: https://en.wikipedia.org/wiki/Earth_radius
    EARTH_MEAN_RADIUS_IN_METERS = 6_357_000.0

    # From: https://en.wikipedia.org/wiki/Radian
    RAD = (Math::PI / 180)

    # From: https://www.thoughtco.com/degree-of-latitude-and-longitude-distance-4070616
    METERS_PER_LATITUDE_DEGREE = 111_000.0

    # From: http://www.csgnetwork.com/degreelenllavcalc.html
    METERS_PER_LONGITUDE_DEGREE = 111_302.62
  end
end
