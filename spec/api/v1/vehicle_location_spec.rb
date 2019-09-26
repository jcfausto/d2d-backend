# frozen_string_literal: true

require 'spec_helper'

describe APIv1::VehicleLocation do
  include Rack::Test::Methods

  def app
    APIv1::VehicleLocation
  end

  let(:content_type) { { 'Content-Type' => 'application/json' } }
  let(:vehicle_id) { 'b49b4c08-3cc9-452f-a812-146cf8864409' }
  let(:payload) { { lat: 51.2, lng: 45.3, at: '2019-12-02T12:00:00+01:00' } }

  describe 'POST /vehicles/:id/locations' do
    it 'should receive vehicle location updates' do
      post "/vehicles/#{vehicle_id}/locations", payload, content_type
      expect(last_response.status).to eq(204)
      expect(last_response.body).to eq('')
    end
  end
end
