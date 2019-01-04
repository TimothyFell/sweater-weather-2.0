require 'rails_helper'

describe 'GoogleService' do
  before(:each) do
    @service = GoogleService.new
  end

  it 'exists' do
    expect(@service).to be_a(GoogleService)
  end

  describe '#get_lat_lon' do

    it 'should return latitude and longitude for a specified location' do
      VCR.use_cassette("google_service_spec") do
        coords = @service.get_lat_lon('denver, co')

        expect(coords).to be_a(Hash)
        expect(coords[:lat]).to eq(39.7392358)
        expect(coords[:lng]).to eq(-104.990251)
      end
    end

  end
end
