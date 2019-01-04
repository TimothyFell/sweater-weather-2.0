class GiphyService

  def self.gifs(time_summary_only)
    new.get_gifs(time_summary_only)
  end

  def get_gifs(time_summary_only)
    time_summary_only.map do |ts|
      q = ts[:summary]
      url = "/v1/gifs/search?q=#{q}"
      ts[:url] = get_json(url)[:data][0][:url]
      ts
    end
  end

  private

  def get_json(url)
    response = conn.get do |req|
      req.url url
      req.params['api_key'] = ENV['GIPHY_API_KEY']
      req.params['rating'] = "g"
      req.params['limit'] = 1
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "http://api.giphy.com")
  end

end
