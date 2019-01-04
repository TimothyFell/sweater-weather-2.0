class GifsFacade

  def initialize(daily_forecast)
    @daily_forecast = daily_forecast
  end

  def daily_gif_forecast
    time_summary_only
  end

  private

  def time_summary_only
    @daily_forecast.map do |d|
      delete_other_key_value_pairs(d)
      binding.pry
    end
  end

  def delete_other_key_value_pairs(d)
    d.delete_if do |k,v|
      k != :time && k != :summary
    end
  end

end
