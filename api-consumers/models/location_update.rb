# frozen_string_literal: true

require 'mongoid'

# Mongoid document model for a location
class LocationUpdate
  include Mongoid::Document
  store_in collection: :locations, database: :d2d

  field :vehicle_id, type: String
  field :lat, type: Float
  field :lng, type: Float
  field :bearing, type: Float
  field :at, type: Time
end
