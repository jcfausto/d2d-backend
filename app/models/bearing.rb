# frozen_string_literal: true

# Object representing a bearing
# degrees clockwise from the true north
# Argument:
#   degrees: Numeric
class Bearing
  attr_reader :value

  def initialize(degrees)
    validate_degrees(degrees)
    @value = degrees
  end

  def ==(other)
    return self.value == other.value
  end

  private

  def validate_degrees(degrees)
    err_message = 'degrees must be a Numeric'
    raise ArgumentError err_message unless degrees.is_a? Numeric
  end
end
