# frozen_string_literal: true

module APIv1
  # All V1 APIs should be mounted by this root class
  # Swagger documentation will be automatically generated
  # for any mounted API on this root.
  class Root < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api

    mount APIv1::VehicleRegistry

    add_swagger_documentation api_version: 'v1',
                              info: {
                                title: 'Vehicle Location Streaming API'
                              }
  end
end
