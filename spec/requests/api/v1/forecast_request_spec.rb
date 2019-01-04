require 'rails_helper'

describe 'Weather for a City' do

  describe 'GET /api/v1/forecast?location=denver,co' do

    before(:each) do
      get '/api/v1/forecast?location=denver,co'
    end

    it 'should return current weather as a json object' do
      expect(response).to be_successful
    end

    xit 'should return hourly forecasts as json objects' do

    end

    xit 'should return daily forecasts as json objects' do

    end

  end

end
