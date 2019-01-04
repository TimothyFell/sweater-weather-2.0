require 'rails_helper'

describe 'Weather for a City' do

  describe 'GET /api/v1/forecast?location=denver,co' do

    before(:each) do
      stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GEOCODING_API_KEY']}").to_return(body: File.read("./spec/fixtures/geocode_response.json"))

      stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/39.7392358,-104.990251").to_return(body: File.read("./spec/fixtures/dark_sky_response.json"))
    end

    it 'should return current weather as a json object' do
      get '/api/v1/forecast?location=denver,co'
      expect(response).to be_successful
    end

    xit 'should return hourly forecasts as json objects' do

    end

    xit 'should return daily forecasts as json objects' do

    end

  end

end
