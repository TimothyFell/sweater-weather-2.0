require 'rails_helper'

describe 'User requests their list of favorites and weather', :type => :request do

  describe 'GET /api/v1/favorites' do

    before(:each) do
      @user_1 = User.create({
        "email"=>"whatever@example.com",
        "password"=>"password",
        "password_confirmation"=>"password",
        "api_key"=>"potato"
      })

      @location_1 = @user_1.favorites.create(location:"denver,co")
      @location_2 = @user_1.favorites.create(location:"boston,ma")

      @headers = { "Content_Type" => "application/json", "Accept" => "application/json" }

      stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GEOCODING_API_KEY']}").to_return(body: File.read("./spec/fixtures/geocode_response.json"))

      stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/39.7392358,-104.990251").to_return(body: File.read("./spec/fixtures/dark_sky_response.json"))

      stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=boston,ma&key=#{ENV['GEOCODING_API_KEY']}").to_return(body: File.read("./spec/fixtures/geocode_response.json"))

      stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/39.7392358,-104.990251").to_return(body: File.read("./spec/fixtures/dark_sky_response.json"))
    end

    it 'Should return a successful response' do
      get "/api/v1/favorites", :params =>
        {"api_key"=>"potato",
         "controller"=>"api/v1/favorites",
         "action"=>"index", "favorite"=>{}}, :headers => @headers

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
    end

    it 'Should return a list of the users favorites' do
      get "/api/v1/favorites", :params =>
        {"api_key"=>"potato",
         "controller"=>"api/v1/favorites",
         "action"=>"index", "favorite"=>{}}, :headers => @headers

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response.first[:location]).to eq("denver,co")
      expect(parsed_response.last[:location]).to eq("boston,ma")
    end

    it 'Should return the current_weather with each favorite' do
      get "/api/v1/favorites", :params =>
        {"api_key"=>"potato",
         "controller"=>"api/v1/favorites",
         "action"=>"index", "favorite"=>{}}, :headers => @headers

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response.first).to have_key(:current_weather)
      expect(parsed_response.last).to have_key(:current_weather)
    end

    describe 'Sad Path' do

      it 'Response should have a status of 401' do
        get "/api/v1/favorites", :params =>
          {"api_key"=>"george",
           "controller"=>"api/v1/favorites",
           "action"=>"index", "favorite"=>{}}, :headers => @headers

        expect(response).to_not be_successful
        expect(response.status).to eq(401)
      end

    end

  end

end
