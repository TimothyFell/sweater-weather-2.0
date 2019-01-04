class GifsFacade < FacadeBase

  def initialize(location)
    @location = location
  end

  def self.daily_gif_forecast_response(location)
    new(location).daily_gif_forecast_response
  end

  def daily_gif_forecast_response
    {
      data: {
        daily_forecasts: daily_gif_forecast
      },
      copyright: "#{Date.today.year}"
    }
  end

  private

  # Helpers

  def daily_gif_forecast
    gif_results(time_summary_only)
  end

  def time_summary_only
    get_daily.map do |d|
      delete_other_key_value_pairs(d)
    end
  end

  def delete_other_key_value_pairs(d)
    d.delete_if do |k,v|
      k != :time && k != :summary
    end
  end

end
