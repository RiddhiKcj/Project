class Api::Widgets::WeatherController < Api::WidgetsController
    before_action :authorize_access_request!
    skip_before_action :verify_authenticity_token, only: :create

    def index
        #FOR PRODUCTION: ip = request.location.ip 
        @location = Geocoder.search("157.41.50.224")
        data = getData
        data[:location] = @location.first.data
        respond_to do |format|
            format.json  { render :json => data }
        end
    end 

    def create
        @location = Geocoder.search(params["city"])
        if params["unixtime"].present?
            data = getData(true)
        else
            data = getData
        end
        data[:location] = @location.first.data["address"]
        respond_to do |format|
            format.json  { render :json => data }
        end
    end

    protected
    def getData(timeRequest = false)
        puts "************************** #{timeRequest} ********************"
        puts "************************** #{@location} ********************"
        if timeRequest == true
            weather_params = '/' + @location.first.coordinates[0].to_s + ',' + @location.first.coordinates[1].to_s + ',' + params["unixtime"].to_s
        else
            weather_params = '/' + @location.first.coordinates[0].to_s + ',' + @location.first.coordinates[1].to_s
        end
        @weatherData = call_api('weather',weather_params)
        data = {
            :weatherData => @weatherData,
            :address => @location.first.address,
        }
        return data
    end

end
