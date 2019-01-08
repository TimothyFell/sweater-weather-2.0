class Api::V1::FavoritesController < ApplicationController

  def index
    if user_by_api_key
      facade = FavoritesFacade.new(user_by_api_key)
      render json: facade.favorites_forecast
    else
      render json:"Unauthorized",status:401
    end
  end

  def create
    if user_by_api_key
      favorite = Favorite.find_or_create_by(location: clean_location)
      user_by_api_key.user_favorites.create(favorite_id: favorite.id)
      render json:'Success',status:204
    else
      render json:'Unauthorized',status:401
    end
  end

  def destroy
    if user_by_api_key
      facade = FavoritesFacade.new(user_by_api_key)
      facade.delete_favorite(clean_location)
      render json:'Accepted',status:202
    else
      render json:'Unauthorized',status:401
    end
  end

  private

  def user_by_api_key
    user = User.find_by(api_key: favorite_params["api_key"])
  end

  def clean_location
    favorite_params["location"].downcase.strip.delete(',').split.join(',')
  end

  def favorite_params
    params.permit("location","api_key")
  end

end
