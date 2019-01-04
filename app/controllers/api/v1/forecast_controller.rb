class Api::V1::ForecastController < ApplicationController
  def show
    coords = GoogleService.lat_lon(params[:location])
    render json: DarkSkyService.forecast(coords[:lat],coords[:lng])
  end
end
