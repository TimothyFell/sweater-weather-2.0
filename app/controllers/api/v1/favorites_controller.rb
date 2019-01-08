class Api::V1::FavoritesController < ApplicationController

  def index

  end

  def create
    user = User.find_by(api_key: favorite_params["api_key"])

    if user
      favorite = Favorite.find_or_create_by(location: clean_location)
      user.user_favorites.create(favorite_id: favorite.id)
      render json:'Success',status:204
    else
      render json:'Unauthorized',status:401
    end
  end

  private

  def clean_location
    favorite_params["location"].downcase.strip.delete(',').split.join(',')
  end

  def favorite_params
    params.permit("location","api_key")
  end

end
