# frozen_string_literal: true

module APIv1
  # Config endpoint
  # Will return the operation parameters
  class Config < Grape::API
    resource :config do
      helpers do
        def allow_cors_when_in_development
          # To allow running the client locally and having access
          # to the API, otherwise CORS will block the call
          return unless ENV['RACK_ENV'] == 'development'

          header 'Access-Control-Allow-Origin', '*'
        end
      end

      before do
        allow_cors_when_in_development
        header 'Content-Type', 'application/json'
      end

      desc 'Return current operation parameters'
      get do
        @city_manager = CityManager.new
        {
          centralPoint: @city_manager.central_point,
          limitRadiusInKm: @city_manager.limit_radius_in_km
        }
      end
    end
  end
end
