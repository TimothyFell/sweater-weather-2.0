require 'rails_helper'

describe 'DarkSkyService' do

  it 'exists' do
    service = DarkSkyService.new
    expect(service).to be_a(DarkSkyService)
  end

  describe '::forecast' do

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

  describe '::daily' do
    it 'should return only the daily weather data' do
      VCR.use_cassette("dark_sky_service_spec") do
        daily = DarkSkyService.daily(39.7392358,-104.990251)

        expect(daily).to be_a(Array)
        expect(daily.first).to have_key(:time)
        expect(daily.first).to have_key(:summary)
      end
    end
  end
end
