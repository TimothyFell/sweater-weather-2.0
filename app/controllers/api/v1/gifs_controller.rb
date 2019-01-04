class Api::V1::GifsController < ApplicationController
  def index
    coords = GoogleService.new.get_lat_lon(params[:location])
    daily_forecast = DarkSkyService.new.get_daily(coords[:lat],coords[:lng])

    facade = GifsFacade.new(daily_forecast)
    render json: facade.daily_gif_forecast
  end
end
