# frozen_string_literal: true

require 'spec_helper'

describe RegisterService do
  let(:vehicle_id) { 'b49b4c08-3cc9-452f-a812-146cf8864409' }
  let(:service) { RegisterService.new }
  let(:namespace) { service.registry_namespace }

  describe 'Registration' do
    it 'should register a vehicle' do
      service.call(vehicle_id)
      expect(Redis.current.get("#{namespace}:#{vehicle_id}")).to eq('true')
    end
  end
end
