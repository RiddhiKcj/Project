class WeatherController < ApplicationController
  require 'rest-client'
  require 'date'
  def index
    @user = current_user
    ip = @user.last_sign_in_ip || @user.current_sign_in_ip
    location = Geocoder.search(ip)
    @address = location.first.address
    lat_lon = location.first.coordinates
    latitude = lat_lon[0]
    longitude = lat_lon[1]
    key = "adedecd668be4b048d9408469258ab9a"
    url = "https://api.darksky.net/forecast/#{key}/#{latitude},#{longitude}"
    @response = JSON.parse(RestClient.get(url))
    p @response
  end

end
