# frozen_string_literal: true

require 'spec_helper'

describe Vehicle do
  let(:uuid) { '8b4778c6-9b44-4ae5-bf30-50d90d0b8949' }
  let(:vehicle) { Vehicle.new(uuid) }

  it 'should initialize with a UUID' do
    expect(vehicle.uuid).to eq(uuid)
  end
end
