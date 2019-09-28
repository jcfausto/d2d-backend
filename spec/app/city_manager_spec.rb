# frozen_string_literal: true

describe CityManager do
  let(:city_manager) { CityManager.new }
  # park center treptower park 6+ km away from ref point
  let(:invalid_location) { Location.new(52.490999, 13.457921) }
  # Hamburger banhof
  let(:valid_location) { Location.new(52.5280396, 13.3607669) }

  describe 'initialization' do
    it 'should initialize without errors' do
      expect { CityManager.new }.not_to raise_error
    end

    it 'should load configurations from city_manager.yml' do
      expect(city_manager.config).not_to eq(nil)
    end
  end

  describe 'location validation' do
    context 'when location is outside city boundaries' do
      it 'should return false' do
        expect(city_manager.valid_location?(invalid_location)).to be false
      end
    end

    context 'when location is valid' do
      it 'should return true' do
        expect(city_manager.valid_location?(valid_location)).to be true
      end
    end
  end
end
