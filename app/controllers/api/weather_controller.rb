class Api::WeatherController < ApplicationController
  before_action :authorize_access_request!
  def index
    user = current_user
    #ip = user.last_sign_in_ip || user.current_sign_in_ip
    @location = Geocoder.search("157.41.50.224")
    @address =  @location.first.address
    latitude = @location.first.coordinates[0]
    longitude = @location.first.coordinates[1]
    weatherApi = Widget.find_by name: 'weather'
    key = weatherApi.apikey  
    #FORMAT-> url  = '..../'#{key}/#{latitude},#{longitude}
    url = weatherApi.url + key + '/' + latitude.to_s + ',' + longitude.to_s
    @weatherData = JSON.parse(RestClient.get(url))
    data = {
      :weatherData => @weatherData,
      :address => @address,
    }
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => data }
    end
  end 

end
