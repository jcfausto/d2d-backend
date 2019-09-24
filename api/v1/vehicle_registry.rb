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
    end
  end
end
