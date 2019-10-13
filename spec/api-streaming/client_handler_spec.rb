# frozen_string_literal: true

require 'spec_helper'

describe ClientConnectionHandler do
  describe 'initialization' do
    it 'should initialize without errors' do
      expect { ClientConnectionHandler.new(ENV) }.not_to raise_error
    end
  end
end
