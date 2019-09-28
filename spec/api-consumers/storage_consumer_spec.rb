# frozen_string_literal: true

require 'spec_helper'

describe StorageConsumer do
  describe 'starting' do
    it 'should start without errors' do
      expect { StorageConsumer.new }.not_to raise_error
    end
  end
end
