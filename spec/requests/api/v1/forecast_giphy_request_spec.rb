require 'rails_helper'

describe 'Weather for a City with Gifs', :type => :request do

  describe 'GET /api/v1/gifs?location=denver,co' do

    before(:each) do
      stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GEOCODING_API_KEY']}").to_return(body: File.read("./spec/fixtures/geocode_response.json"))

      stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/39.7392358,-104.990251").to_return(body: File.read("./spec/fixtures/dark_sky_response.json"))
    end

    it 'should have a successful response' do
      get '/api/v1/gifs?location=denver,co'

      expect(response).to be_successful
    end

    it 'should be an array' do
      get '/api/v1/gifs?location=denver,co'

      parsed_response = JSON.parse(response.body)

      expect(parsed_response).to be_a(Array)
      binding.pry
    end

  end

end
