class Api::V1::GifsController < ApplicationController
  def index
    # coords = GoogleService.lat_lon(params[:location])
    # daily_forecast = DarkSkyService.daily(coords[:lat],coords[:lng])
    #
    # facade = GifsFacade.new(daily_forecast)
    # render json: facade.daily_gif_forecast_response

    render json: GifsFacade.daily_gif_forecast_response(params[:location])
  end
end
