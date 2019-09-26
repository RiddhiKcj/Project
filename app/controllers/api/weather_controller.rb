class Api::WeatherController < ApplicationController
  def index
    user = current_user
    ip = user.last_sign_in_ip || user.current_sign_in_ip
    @location = Geocoder.search(ip)
    @address =  @location.first.address
    latitude = @location.first.coordinates[0]
    longitude = @location.first.coordinates[1]
    weatherApi = Globalapi.find_by name: 'weather'
    key = weatherApi.api  
    # url format = '..../'#{key}/#{latitude},#{longitude}
    url = weatherApi.url + key + '/' + latitude.to_s + ',' + longitude.to_s
    responseData = RestClient.get(url)
    @weatherData =  JSON.parse(responseData)
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => responseData }
    end
  end 

end
