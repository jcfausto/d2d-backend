# frozen_string_literal: true

require 'spec_helper'

describe APIv1::Config do
  include Rack::Test::Methods

  let(:response) do
    {
      centralPoint: {
        lat: 52.53,
        lng: 13.403
      },
      limitRadiusInKm: 3.5
    }.to_json
  end

  def app
    APIv1::Config
  end

  describe 'GET /config' do
    it 'should return application configuration' do
      get '/config'
      expect(last_response.status).to eq(200)
      expect(last_response.header['Content-Type']).to eq('application/json')
      expect(last_response.body).to eq(response)
    end
  end
end
