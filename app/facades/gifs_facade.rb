class GifsFacade

  def initialize(daily_forecast)
    @daily_forecast = daily_forecast
  end

  def daily_gif_forecast
    gif_results(time_summary_only)
  end

  private

  # Helpers

  def time_summary_only
    @daily_forecast.map do |d|
      delete_other_key_value_pairs(d)
    end
  end

  def delete_other_key_value_pairs(d)
    d.delete_if do |k,v|
      k != :time && k != :summary
    end
  end

  # Api Helpers

  def gif_results(time_summary_only)
    @_gif_results ||= service.get_gifs(time_summary_only)
  end

  def service
    @_service ||= GiphyService.new
  end

end
