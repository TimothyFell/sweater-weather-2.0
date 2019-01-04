class FacadeBase

  private

  def get_lat_lon
    GoogleService.lat_lon(@location)
  end

  def get_forecast
    DarkSkyService.forecast(get_lat_lon[:lat],get_lat_lon[:lng])
  end

  def get_daily
    DarkSkyService.daily(get_lat_lon[:lat],get_lat_lon[:lng])
  end

  def gif_results(time_summary_only)
    GiphyService.gifs(time_summary_only)
  end

end
