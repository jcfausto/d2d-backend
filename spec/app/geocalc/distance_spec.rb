# frozen_string_literal: true

require 'spec_helper'

describe 'GeoCalc' do
  describe 'Spherical distance between' do
    let(:point_one) { Location.new(0.0, 0.0) }
    let(:point_two) { Location.new(0.0, 1.0) }

    it 'should be equal to 110951' do
      expect(GeoCalc.distance_between(point_one, point_two).value.round).to eq(110_951)
    end
  end

  describe 'Spherical distance between two close points' do
    let(:point_one) { Location.new(52.531151, 13.375673) }
    let(:point_two) { Location.new(52.531941, 13.377818) }

    it 'should be equal to 169' do
      expect(GeoCalc.distance_between(point_one, point_two).value.round).to eq(169)
    end
  end

  describe 'Spherical distance between LA city hall and NY City Hall' do
    let(:la_city_hall) { Location.new(34.0459068, -118.2715222) }
    let(:ny_city_hall) { Location.new(40.7127784, -74.0082477) }

    context 'when performing long distance calculations' do
      it 'error should be less than 600 meters' do
        distance = GeoCalc.distance_between(la_city_hall, ny_city_hall).value.round
        # distance calculation from google as a reference for comparison
        google_distance = 4_489_000.0

        # less than 300m of error for long distances
        expect((distance - google_distance).abs / 1000).to be < 600
      end
    end
  end
end
