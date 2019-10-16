class Api::Widgets::WeatherController < ApplicationController
  before_action :authorize_access_request!
  skip_before_action :verify_authenticity_token, only: :create
  def index
    #ip = request.location.ip
    @location = Geocoder.search("157.41.50.224")
    data = getData("forecast")
    data[:location] = @location.first.data
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => data }
    end
  end 
  def create
    @city = params["city"]
    @location = Geocoder.search(@city)
    if params["unixtime"].present?
      data = getData("timeRequest")
    else
      data = getData("forecast")
    end
    data[:location] = @location.first.data["address"]
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => data }
    end
  end

  protected
  def getData(dataType)
    @address =  @location.first.address
    latitude = @location.first.coordinates[0]
    longitude = @location.first.coordinates[1]
    weatherApi = Widget.find_by name: 'weather'
    key = weatherApi.apikey  
    #FORMAT-> url  = '..../'#{key}/#{latitude},#{longitude}
    if dataType == "forecast"
      url = weatherApi.url + key + '/' + latitude.to_s + ',' + longitude.to_s
    else
      url = weatherApi.url + key + '/' + latitude.to_s + ',' + longitude.to_s + ',' + params["unixtime"].to_s
    end
    @weatherData = JSON.parse(RestClient.get(url))
    data = {
      :weatherData => @weatherData,
      :address => @address,
    }
    return data
  end
end
