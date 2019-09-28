# frozen_string_literal: true

# Model representing a location
class Location
  attr_reader :lat, :lng

  def initialize(lat, lng)
    @lat = lat
    @lng = lng
  end
end