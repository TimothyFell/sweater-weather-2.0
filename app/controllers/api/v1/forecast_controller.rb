class Api::V1::ForecastController < ApplicationController
  def show
    # coords = GoogleService.new.get_lat_lon(params[:location])
    # binding.pry
    # DarkSkyService.new.get_forecast(lat,lng)
  end
end
