# frozen_string_literal: true

require 'spec_helper'

describe DeRegisterService do
  let(:vehicle_id) { 'b49b4c08-3cc9-452f-a812-146cf8864409' }
  let(:service) { DeRegisterService.new }
  let(:namespace) { service.registry_namespace }

  describe 'De-registration' do
    it 'should de-register a vehicle' do
      service.call(vehicle_id)
      expect(Redis.current.get("#{namespace}:#{vehicle_id}")).to eq(nil)
    end
  end
end
