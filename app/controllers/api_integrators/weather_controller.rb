module ApiIntegrators
  class WeatherController < ApplicationController
    include ApiCaller
    include LocationFetcher
    require 'date'
    def index
      initLocation
      latitude = getLatitude
      longitude = getLongitude
      key = "adedecd668be4b048d9408469258ab9a"
      url = "https://api.darksky.net/forecast/#{key}/#{latitude},#{longitude}"
      @weatherData = newCall(url)
    end 

  end
end