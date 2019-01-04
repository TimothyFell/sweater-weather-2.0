class Api::V1::GifsController < ApplicationController
  def index
    render json: GifsFacade.daily_gif_forecast_response(params[:location])
  end
end
