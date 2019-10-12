# frozen_string_literal: true

module APIv1
  # Config endpoint
  # Will return the operation parameters
  class Config < Grape::API
    resource :config do
      before do
        header 'Access-Control-Allow-Origin', '*'
        header 'Content-Type', 'application/json'
      end

      desc 'Operation Parameters'
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
