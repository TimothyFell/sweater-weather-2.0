class Api::V1::ForecastController < ApplicationController
  def show
    render json: ForecastFacade.forecast_response(params[:location])
  end
end
