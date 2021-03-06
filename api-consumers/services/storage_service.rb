# frozen_string_literal: true

require_relative '../models/location_update'

# Service Object responsible for storing
# vehicle locations on a permanent storage
# Arguments:
#   location: json object compliant with
#             pec/support/api/schemas/location_update.json
class StorageService
  def call(location)
    hash = location_hash(location)
    LocationUpdate.create(hash)
  rescue Mongo::OperationFailure => e
    puts "Location #{location} not stored: #{e}"
  end

  private

  def location_hash(location)
    JSON.parse(location)
  rescue JSON::ParserError => e
    puts "Error parsing location #{location}: #{e}"
  end
end
