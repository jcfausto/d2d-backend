# frozen_string_literal: true

require 'spec_helper'

describe LocationNotification do
  let(:uuid) { '8b4778c6-9b44-4ae5-bf30-50d90d0b8949' }
  let(:location) { Location.new(54.53, 13.014) }
  let(:last_location) { Location.new(54.53, 13.014) }
  let(:vehicle) { Vehicle.new(uuid) }
  let(:notification_time) { Time.now.iso8601 }
  let(:city_manager) { CityManager.new }
  let(:bearing) { Bearing.new(90.0) }
  let(:params) { { vehicle: vehicle, location: location, last_location: last_location, notification_time: notification_time, city_manager: city_manager } }
  let(:location_notification) { LocationNotification.new(params) }

  describe 'initialization' do
    context 'with valid params' do
      it 'should initialize' do
        expect { LocationNotification.new(params) }.not_to raise_error
      end

      it 'should initialize vehicle' do
        expect(location_notification.vehicle).to eq(vehicle)
      end

      it 'should initialize location' do
        expect(location_notification.location).to eq(location)
      end

      it 'should initialize notification time' do
        expect(location_notification.notification_time).to eq(notification_time)
      end

      it 'should set correct bearing' do
        expect(location_notification.bearing).to eq(bearing)
      end
    end

    context 'whith invalid params' do
      it 'should raise error when invalid vehicle' do
        invalid_params = { vehicle: 123, location: location, notification_time: notification_time }
        expect { LocationNotification.new(invalid_params) }.to raise_error(ArgumentError)
      end

      it 'should raise error when invalid location' do
        invalid_params = { vehicle: vehicle, location: 123, notification_time: notification_time }
        expect { LocationNotification.new(invalid_params) }.to raise_error(ArgumentError)
      end

      it 'should raise error when invalid notification time' do
        invalid_params = { vehicle: vehicle, location: location, notification_time: '2011-10-05' }
        expect { LocationNotification.new(invalid_params) }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'response' do
    it 'should respond as_json with correct schema' do
      expect(location_notification.as_json).to match_json_schema('location_update')
    end
  end
end
