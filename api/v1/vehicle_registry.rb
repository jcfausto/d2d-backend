# frozen_string_literal: true

module APIv1
  # Vehicle Registry API
  # API responsible for registering and de-registering vehicles
  class VehicleRegistry < Grape::API
    resource :vehicles do
      desc 'VehicleRegistry API Healthcheck'
      get :health do
        { health: 'OK' }
      end

      desc 'Registers a vehicle'
      params do
        requires :id, type: String, desc: 'Vehicle UUID'
      end
      post do
        RegisterService.new.call(params[:id])
        status :no_content
      rescue StandardError
        status :internal_server_error
      end

      desc 'De-registers a vehicle'
      params do
        requires :id, type: String, desc: 'Vehicle UUID'
      end
      delete ':id' do
        DeRegisterService.new.call(params[:id])
        status :no_content
        body false
      rescue StandardError
        status :internal_server_error
      end
    end
  end
end
