require 'rails_helper'

describe 'GiphyService' do

  before(:each) do
    @service = GiphyService.new

    @time_summary_only = [
      {:time=>1546498800, :summary=>"Clear throughout the day."},
      {:time=>1546585200, :summary=>"Clear throughout the day."},
      {:time=>1546671600, :summary=>"Mostly cloudy starting in the afternoon."},
      {:time=>1546758000, :summary=>"Partly cloudy throughout the day."},
      {:time=>1546844400, :summary=>"Mostly cloudy throughout the day."},
      {:time=>1546930800, :summary=>"Mostly cloudy until evening."},
      {:time=>1547017200, :summary=>"Mostly cloudy throughout the day."},
      {:time=>1547103600, :summary=>"Mostly cloudy starting in the afternoon."}
    ]
  end

  it 'exists' do
    expect(@service).to be_a(GiphyService)
  end

  describe '#get_gifs' do

    it 'should return an array with time, summary and url for each entry' do
      VCR.use_cassette("giphy_service_spec") do

        response_content = @service.get_gifs(@time_summary_only)

        expect(response_content).to be_a(Array)
        expect(response_content.first).to have_key(:time)
        expect(response_content.first).to have_key(:summary)
        expect(response_content.first).to have_key(:url)
      end
    end
  end

end
