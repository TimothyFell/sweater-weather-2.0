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

end
