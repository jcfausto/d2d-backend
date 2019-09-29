# frozen_string_literal: true

require 'spec_helper'

describe StorageService do
  let(:uuid) { '8b4778c6-9b44-4ae5-bf30-50d90d0b8949' }
  let(:location) { Location.new(54.53, 13.014) }
  let(:vehicle) { Vehicle.new(uuid) }
  let(:notification_time) { Time.now.iso8601 }
  let(:city_manager) { CityManager.new }
  let(:params) { { vehicle: vehicle, location: location, notification_time: notification_time, city_manager: city_manager } }
  let(:location_notification) { LocationNotification.new(params) }

  describe 'initialization' do
    it 'should initialize without errors' do
      expect { StorageService.new }.not_to raise_error
    end
  end

  describe 'call' do
    it 'should store a location update' do
      storage_service = StorageService.new
      location_update = location_notification.as_json
      expect { storage_service.call(location_update) }.not_to raise_error
    end
  end
end
