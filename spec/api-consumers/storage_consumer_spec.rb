# frozen_string_literal: true

require 'spec_helper'

describe StorageConsumer do
  it 'should intialize' do
    expect { StorageConsumer.new }.not_to raise_error
  end
end
