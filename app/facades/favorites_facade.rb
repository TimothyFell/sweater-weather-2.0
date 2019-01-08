class FavoritesFacade < FacadeBase

  def initialize(user)
    @user = user
  end

  def favorites_forecast
    @user.favorites.map do |fav|
      @location = fav.location
      {
        "location": "#{@location}",
        "current_weather": get_current
      }
    end
  end

  def delete_favorite(location)
      user_favorites = @user.user_favorites
      favorite_id = Favorite.find_by(location: location).id
      user_favorites.each { |user_fav|
        user_fav.destroy if user_fav.favorite_id == favorite_id
      }
  end

end
