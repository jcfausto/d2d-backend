# frozen_string_literal: true

require 'spec_helper'

describe Location do
  let(:lat) { 52.53 }
  let(:lng) { 13.412 }

  before(:each) do
    @location = Location.new(lat, lng)
  end

  it 'should initialize with latitude and longitude' do
    expect(@location.lat).to eq(lat)
    expect(@location.lng).to eq(lng)
  end

  it 'should return coordinates' do
    expect(@location.coordinates).to eq([lat, lng])
  end
end
