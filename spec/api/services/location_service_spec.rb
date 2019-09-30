# frozen_string_literal: true

describe LocationService do
  # park center treptower park 6+ km away from ref point
  # 52.490999, 13.457921
  let(:invalid_location) do
    {
      lat: 52.490999,
      lng: 13.457921,
      at: '2019-09-26T22:51:31+0200',
      id: '4c3baaea-6512-4af1-a88b-81aeeba9369a'
    }
  end
  # Hamburger banhof 52.5280396, 13.3607669
  let(:valid_location) do
    {
      lat: 52.5280396,
      lng: 13.3607669,
      at: '2019-09-26T22:51:31+0200',
      id: '4c3baaea-6512-4af1-a88b-81aeeba9369a'
    }
  end

  describe 'initialization' do
    it 'should initialize without errors' do
      expect { LocationService.new }.not_to raise_error
    end
  end

  describe 'publish' do
    # it 'should publish valid locations' do
    #   @redis = Redis.new
    #   allow(@redis).to receive(:publish)
    #   LocationService.new.call(valid_location)
    #   expect(@redis).to have_received(:publish)
    # end

    # it 'should not publish invalid locations' do
    #   allow(Redis).to receive(:publish)
    #   LocationService.new.call(invalid_location)
    #   expect(Redis).not_to have_received(:publish)
    # end
  end
end
