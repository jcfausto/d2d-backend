# frozen_string_literal: true

require_relative '../models/location_update'

# Service Object responsible for storing
# vehicle locations on a permanent storage
class StorageService
  def call(location)
    hash = location_hash(location)
    LocationUpdate.create(hash)
  rescue Mongo::OperationFailure => e
    puts "Location #{location} not stored: #{e}"
  rescue Mongo::MongoRubyError => e
    puts "Ruby Error: #{e}"
  rescue Mongo::MongoDBError => e
    puts "DB Error: #{e}"
  end

  private

  def location_hash(location)
    hash = JSON.parse(location)
    hash['vehicle_id'] = hash.delete('id')
    hash
  rescue JSON::ParserError => e
    puts "Invalid location #{location}: #{e}"
  end
end
