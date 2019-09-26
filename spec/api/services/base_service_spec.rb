# frozen_string_literal: true

require 'spec_helper'

describe BaseService do
  let(:vehicle_registry_namespace_name) { 'vehicle_registry' }
  let(:location_channel_name) { 'location_channel' }

  before(:each) do
    ENV['VEHICLE_REGISTRY_REDIS_NAMESPACE'] = vehicle_registry_namespace_name
    ENV['VEHICLE_LOCATION_REDIS_CHANNEL'] = location_channel_name

    @base_service = BaseService.new
  end

  it 'should initialize registry namespace name' do
    expect(@base_service.registry_namespace).to eq(vehicle_registry_namespace_name)
  end

  it 'should initialize location channel name' do
    expect(@base_service.location_channel).to eq(location_channel_name)
  end
end
