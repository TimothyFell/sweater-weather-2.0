require 'rails_helper'

describe 'Weather for a City with Gifs', :type => :request do

  describe 'GET /api/v1/gifs?location=denver,co' do

    before(:each) do
      stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GEOCODING_API_KEY']}").to_return(body: File.read("./spec/fixtures/geocode_response.json"))

      stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/39.7392358,-104.990251").to_return(body: File.read("./spec/fixtures/dark_sky_response.json"))

      VCR.use_cassette("giphy_request_spec") do
        get '/api/v1/gifs?location=denver,co'
      end

      @parsed_response = JSON.parse(response.body, symbolize_names: true)
    end

    it 'should have a successful response' do
      expect(response).to be_successful
    end

    it 'the response should contain an array' do
      expect(@parsed_response).to be_a(Hash)
      expect(@parsed_response[:data][:daily_forecasts]).to be_a(Array)
    end

    describe 'each entry in the array should have the following keys' do

      it ':time' do
        expect(@parsed_response[:data][:daily_forecasts].first).to have_key(:time)
      end

      it ':summary' do
        expect(@parsed_response[:data][:daily_forecasts].first).to have_key(:summary)
      end

      it ':url' do
        expect(@parsed_response[:data][:daily_forecasts].first).to have_key(:url)
      end
    end

  end

end
