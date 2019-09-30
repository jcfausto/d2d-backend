# frozen_string_literal: true

require 'spec_helper'

describe LocationUpdate, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to be_stored_in(collection: 'locations') }

  # Field validation
  it { is_expected.to have_field(:vehicle_id).of_type(String) }
  it { is_expected.to have_field(:lat).of_type(Float) }
  it { is_expected.to have_field(:lng).of_type(Float) }
  it { is_expected.to have_field(:at).of_type(Time) }
end
