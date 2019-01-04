class GoogleService

  def self.lat_lon(location)
    new.get_lat_lon(location)
  end

  def get_lat_lon(location)
    response = get_json("/maps/api/geocode/json?address=#{location}&key=#{ENV['GEOCODING_API_KEY']}")
    response[:results][0][:geometry][:location]
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://maps.googleapis.com")
  end

end
