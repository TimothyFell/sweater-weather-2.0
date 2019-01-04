class ForecastFacade < FacadeBase

  def initialize(location)
    @location = location
  end

  def self.forecast_response(location)
    new(location).forecast_response
  end

  def forecast_response
    get_forecast
  end

end
