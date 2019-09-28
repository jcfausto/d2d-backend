# frozen_string_literal: true

require 'spec_helper'

describe Distance do
  before(:each) do
    @distance = Distance.new(1000)
  end

  it 'should return distance in km' do
    expect(@distance.in_km).to eq(1)
  end

  it 'should allow access to its value' do
    expect(@distance.value).to eq(1000)
  end
end
