# frozen_string_literal: true

require 'spec_helper'

describe APIv1::VehicleRegistry do
  include Rack::Test::Methods

  def app
    APIv1::VehicleRegistry
  end

  let(:content_type) { { 'Content-Type' => 'application/json' } }
  let(:vehicle_id) { 'b49b4c08-3cc9-452f-a812-146cf8864409' }
  let(:payload) { { id: vehicle_id } }

  describe 'GET /vehicles/health' do
    it 'should be healthy' do
      get '/vehicles/health'
      expect(last_response.status).to eq(200)
    end
  end

  describe 'POST /vehicles' do
    it 'should register a vehicle' do
      post '/vehicles', payload, content_type
      expect(last_response.status).to eq(204)
    end
  end

  describe 'DELETE /vehicles/:id' do
    it 'should de-register a vehicle' do
      delete "/vehicles/#{vehicle_id}"
      expect(last_response.status).to eq(204)
      expect(last_response.body).to eq('')
    end
  end
end
