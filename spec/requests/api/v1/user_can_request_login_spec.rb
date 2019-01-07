require 'rails_helper'

describe 'User Login Request' do

  describe 'POST /api/v1/sessions' do

    describe 'positive path' do

      before(:each) do
        user = User.create({
          "email"=>"whatever@example.com",
          "password"=>"password",
          "password_confirmation"=>"password",
          "api_key"=>"potato"
        })

        headers = { "Content_Type" => "application/json", "Accept" => "application/json" }

        post "/api/v1/sessions", :params =>
          {"email"=>"whatever@example.com",
           "password"=>"password",
           "controller"=>"api/v1/sessions",
           "action"=>"create", "session"=>{"email"=>"whatever@example.com", "password"=>"password"}}, :headers => headers
      end

      it 'should be successful' do
        expect(response).to be_successful
      end

      it 'should return the users api_key' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to be_a(Hash)
        expect(parsed_response).to have_key("api_key")
        expect(parsed_response).to have_value("potato")
      end

    end

    describe 'if the user inst in the database' do

      it 'should return a 401 error' do
        headers = { "Content_Type" => "application/json", "Accept" => "application/json" }

        post "/api/v1/sessions", :params =>
          {"email"=>"whatever@example.com",
           "password"=>"password",
           "controller"=>"api/v1/sessions",
           "action"=>"create", "session"=>{"email"=>"whatever@example.com", "password"=>"password"}}, :headers => headers

        expect(response).to_not be_successful
      end

    end

  end

end
