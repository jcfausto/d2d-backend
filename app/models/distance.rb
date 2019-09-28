# frozen_string_literal: true

# Object representing a distance and
# offering some helper methods for
# metric conversion.
# Argument:
#   distance: Numeric
class Distance
  attr_reader :value

  def initialize(distance)
    validate_distance(distance)
    @value = distance
  end

  def in_km
    @value / 1000
  end

  private

  def validate_distance(distance)
    err_message = 'distance must be a Numeric'
    raise ArgumentError err_message unless distance.is_a? Numeric
  end
end
