# frozen_string_literal: true

require 'spec_helper'

describe Bearing do
  let(:point_one) { Location.new(0, 0) }
  let(:point_two) { Location.new(0, 1) }

  it 'should be equal to 90 degrees clockwise from true north' do
    expect(GeoCalc.bearing_between(point_one, point_two).value.round).to eq(90)
  end
end
