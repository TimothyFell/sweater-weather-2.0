class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: session_params["email"])
    session['user_id'] = user.id
    response = { "api_key"=>"#{user.api_key}" }
    render json: response
  end

  private

  def session_params
    params.require("session").permit("email","password")
  end

end
