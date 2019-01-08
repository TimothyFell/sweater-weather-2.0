require 'rails_helper'

describe 'User Favorites Locations' do

  describe 'POST /api/v1/favorites' do

    describe 'positive path' do

      before(:each) do
        @user_1 = User.create({
          "email"=>"whatever@example.com",
          "password"=>"password",
          "password_confirmation"=>"password",
          "api_key"=>"potato"
        })
        @user_2 = User.create({
          "email"=>"bob@example.com",
          "password"=>"password",
          "password_confirmation"=>"password",
          "api_key"=>"carrot"
        })
      end

      it 'should be successful' do
        headers = { "Content_Type" => "application/json", "Accept" => "application/json" }

        post "/api/v1/favorites", :params =>
          {"location"=>"Denver, CO",
           "api_key"=>"potato",
           "controller"=>"api/v1/favorites",
           "action"=>"create", "favorite"=>{"location"=>"Denver, CO",
            "api_key"=>"potato"}}, :headers => headers

        expect(response).to be_successful
      end

      it 'should create a favorite for the user' do
        headers = { "Content_Type" => "application/json", "Accept" => "application/json" }

        post "/api/v1/favorites", :params =>
          {"location"=>"Denver, CO",
           "api_key"=>"potato",
           "controller"=>"api/v1/favorites",
           "action"=>"create", "favorite"=>{"location"=>"Denver, CO",
            "api_key"=>"potato"}}, :headers => headers

        expect(Favorite.last.location).to eq("denver,co")
      end

      it 'different users can have the same favorite' do
        headers = { "Content_Type" => "application/json", "Accept" => "application/json" }

        post "/api/v1/favorites", :params =>
          {"location"=>"Denver, CO",
           "api_key"=>"potato",
           "controller"=>"api/v1/favorites",
           "action"=>"create", "favorite"=>{"location"=>"Denver, CO",
            "api_key"=>"potato"}}, :headers => headers

        headers = { "Content_Type" => "application/json", "Accept" => "application/json" }

        post "/api/v1/favorites", :params =>
          {"location"=>"Denver, CO",
           "api_key"=>"carrot",
           "controller"=>"api/v1/favorites",
           "action"=>"create", "favorite"=>{"location"=>"Denver co",
            "api_key"=>"carrot"}}, :headers => headers

        expect(UserFavorite.all.count).to eq(2)
        expect(UserFavorite.first.user_id).to eq(@user_1.id)
        expect(UserFavorite.last.user_id).to eq(@user_2.id)
        expect(Favorite.all.count).to eq(1)
      end

      describe 'if the api_key is incorrect' do
        it 'it should return 401 error' do
          headers = { "Content_Type" => "application/json", "Accept" => "application/json" }

          post "/api/v1/favorites", :params =>
            {"location"=>"Denver, CO",
             "api_key"=>"george",
             "controller"=>"api/v1/favorites",
             "action"=>"create", "favorite"=>{"location"=>"Denver, CO",
              "api_key"=>"george"}}, :headers => headers
          expect(response).to_not be_successful
        end
      end

    end

    describe 'if the user inst in the database' do

      it 'should return a 401 error' do
        headers = { "Content_Type" => "application/json", "Accept" => "application/json" }

        post "/api/v1/favorites", :params =>
          {"lcoation"=>"Peanut, PA",
           "api_key"=>"joe",
           "controller"=>"api/v1/favorites",
           "action"=>"create", "favorite"=>{"lcoation"=>"Peanut, PA", "api_key"=>"joe"}}, :headers => headers

        expect(response).to_not be_successful
      end

    end

  end

end
