module ApiCaller extend ActiveSupport::Concern
    require 'rest-client'

    # url = Third-Party url + api_key(if needed)
    def newCall(url)
        rawData = RestClient.get(url)
        parsedData = JSON.parse(rawData)
        return parsedData
    end 
end