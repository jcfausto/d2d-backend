# frozen_string_literal: true

require 'mongoid'

# Model representing a location update
class LocationUpdate
  include Mongoid::Document

  store_in collection: :locations

  field :vehicle_id, type: String
  field :lat, type: Float
  field :lng, type: Float
  field :at, type: Time
end
