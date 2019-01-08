class Api::V1::UsersController < ApplicationController

  def create
    new_user = User.user_create(user_params)
    response = { "api_key" => "#{new_user.api_key}" }
    render json: response,status:201
  end

  private

  def user_params
    params.permit("email","password","password_confirmation")
  end

end
