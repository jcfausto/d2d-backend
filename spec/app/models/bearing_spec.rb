# frozen_string_literal: true

require 'spec_helper'

describe Bearing do
  before(:each) do
    @bearing = Bearing.new(213.75)
  end

  it 'should allow access to its value' do
    expect(@bearing.value).to eq(213.75)
  end
end
