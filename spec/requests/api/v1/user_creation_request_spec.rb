require 'rails_helper'

describe 'Account Creation', :type => :request do

  describe 'POST /api/v1/users' do

    it 'exists' do
      headers = { "Content_Type" => "application/json", "Accept" => "application/json" }

      post "/api/v1/users", :params => {"email"=>"whatever@example.com",
         "password"=>"password",
         "password_confirmation"=>"password",
         "controller"=>"api/v1/users",
         "action"=>"create",
         "user"=>{"email"=>"whatever@example.com"}}, :headers => headers

      expect(request.params.keys).to include("email")
      expect(request.params.keys).to include("password")
      expect(request.params.keys).to include("password_confirmation")
      expect(request.params.keys).to include("controller")
      expect(request.params.keys).to include("action")
      expect(request.params.keys).to include("user")

      expect(response).to be_successful

      expect(User.last.email).to eq("whatever@example.com")

      response_hash = JSON.parse(response.body)

      expect(response_hash.keys).to include("api_key")
    end

  end

end
