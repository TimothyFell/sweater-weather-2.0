class Api::V1::ForecastController < ApplicationController
  def show
    coords = GoogleService.new.get_lat_lon(params[:location])
    DarkSkyService.new.get_forecast(coords[:lat],coords[:lng])
  end
end
