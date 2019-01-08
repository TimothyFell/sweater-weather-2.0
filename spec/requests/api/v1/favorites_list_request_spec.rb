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
      @headers = { "Content_Type" => "application/json", "Accept" => "application/json" }
    end

    describe 'Happy Paths' do

      it 'Should return a successful response' do
        get "/api/v1/favorites", :params =>
          {"api_key"=>"potato",
           "controller"=>"api/v1/favorites",
           "action"=>"create", "favorite"=>{"location"=>"Denver, CO",
            "api_key"=>"potato"}}, :headers => @headers

        expect(response).to be_successful
      end

    end

  end

end
