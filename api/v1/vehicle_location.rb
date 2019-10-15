# frozen_string_literal: true

module APIv1
  # Vehicle Location API
  # API responsible for receiving vehicle location updates
  class VehicleLocation < Grape::API
    resource :vehicles do
      desc 'Receives a vehicle location update', success: { code: 204 }
      params do
        requires :id, type: String, desc: 'Vehicle UUID'
        requires :lat, type: Float, desc: 'Vehicle\'s latitude'
        requires :lng, type: Float, desc: 'Vehicle\'s longitude'
        requires :at, type: DateTime, desc: 'Reporting time'
      end
      post '/:id/locations' do
        LocationService.new.call(params)
        status :no_content
        body false
      rescue StandardError
        status :internal_server_error
      end
    end
  end
end
