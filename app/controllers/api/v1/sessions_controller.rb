class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: session_params["email"])
    if user && user.authenticate(session_params["password"])
      session['user_id'] = user.id
      render json:{ "api_key"=>"#{user.api_key}" },status:200
    else
      render json:'Error',status:401
    end
  end

  private

  def session_params
    params.require("session").permit("email","password")
  end

end
