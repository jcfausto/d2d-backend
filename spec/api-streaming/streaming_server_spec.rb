# frozen_string_literal: true

require 'spec_helper'

describe StreamingServer do
  describe 'initialization' do
    it 'should initialize without errors' do
      expect { StreamingServer.new }.not_to raise_error
    end
  end
end
