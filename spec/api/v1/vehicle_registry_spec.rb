# frozen_string_literal: true

require 'spec_helper'

describe APIv1::VehicleRegistry do
  include Rack::Test::Methods

  def app
    APIv1::VehicleRegistry
  end

  describe 'GET /vehicles/health' do
    it 'should be healthy' do
      get '/vehicles/health'
      expect(last_response.status).to eq(200)
    end
  end
end
