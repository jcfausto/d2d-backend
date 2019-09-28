# frozen_string_literal: true

# Model representing a Vehicle
class Vehicle
  attr_reader :uuid

  def initialize(uuid)
    raise ArgumentError('invalid UUID') unless uuid.is_a? String

    @uuid = uuid
  end
end
