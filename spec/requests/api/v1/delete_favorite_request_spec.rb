require 'rails_helper'

describe 'User sends a request to delete a favorite', :type => :request do

  describe 'DELETE /api/v1/favorites' do

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
    end

    describe 'Successful Response' do

      before(:each) do
        delete "/api/v1/favorites", :params =>
          {"api_key"=>"potato",
           "location"=>"Denver, CO",
           "controller"=>"api/v1/favorites",
           "action"=>"destroy", "favorite"=>{}}, :headers => @headers
      end

      it 'should be successful' do
        expect(response).to be_successful
      end

      it 'Response status should be 202' do
        expect(response.status).to eq(202)
      end

      it 'should only be one entry in user_favorites table' do
        expect(@user_1.user_favorites.all.count).to eq(1)
        expect(@user_1.user_favorites.first.favorite_id).to eq(@location_2.id)
      end

    end

    describe 'Unsuccessful Response, status 401' do

      it 'if api_key is incorrect' do
        delete "/api/v1/favorites", :params =>
          {"api_key"=>"george",
           "location"=>"Denver, CO",
           "controller"=>"api/v1/favorites",
           "action"=>"destroy", "favorite"=>{}}, :headers => @headers

        expect(response).to_not be_successful
        expect(response.status).to eq(401)
      end

      it 'if location isnt a users favorite' do
        delete "/api/v1/favorites", :params =>
          {"api_key"=>"potato",
           "location"=>"New York, NY",
           "controller"=>"api/v1/favorites",
           "action"=>"destroy", "favorite"=>{}}, :headers => @headers

        expect(response).to_not be_successful
        expect(response.status).to eq(401)
      end

    end

  end

end
