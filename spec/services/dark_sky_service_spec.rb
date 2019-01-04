require 'rails_helper'

describe 'DarkSkyService' do
  before(:each) do
    @service = DarkSkyService.new
  end

  it 'exists' do
    expect(@service).to be_a(DarkSkyService)
  end

  describe '#get_forecast' do

    it 'should return hash of weather data for a specified location' do
      VCR.use_cassette("dark_sky_service_spec") do
        forecast = DarkSkyService.forecast(39.7392358,-104.990251)

        expect(forecast).to be_a(Hash)
        expect(forecast).to have_key(:currently)
        expect(forecast).to have_key(:hourly)
        expect(forecast).to have_key(:daily)
        expect(forecast[:hourly][:data]).to be_a(Array)
        expect(forecast[:daily][:data]).to be_a(Array)
      end
    end

  end
end
