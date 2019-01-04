class DarkSkyService

  def get_daily(lat,lng)
    get_forecast(lat,lng)[:daily][:data]
  end

  def get_forecast(lat,lng)
    get_json("forecast/#{ENV['DARK_SKY_API_KEY']}/#{lat},#{lng}")
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.darksky.net/")
  end

end
