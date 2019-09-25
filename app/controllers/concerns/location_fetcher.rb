module LocationFetcher extend ActiveSupport::Concern

    @location
    def getAddress
        @location.first.address
    end

    def getLatitudeLongitude
        @location.first.coordinates
    end

    def getLatitude
        @location.first.coordinates[0]
    end

    def getLongitude
        @location.first.coordinates[1]
    end
    
    def getCountry
        @location.first.country
    end

    def initLocation
        user = current_user
        ip = user.last_sign_in_ip || user.current_sign_in_ip
        @location = Geocoder.search(ip)
    end
end