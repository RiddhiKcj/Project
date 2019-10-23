class Api::WidgetsController < ApplicationController
    protected
    def call_api(api_name, params=nil)
        api = Widget.find_by name: api_name
        key = api.apikey
        url = api.url + key
        if params != nil
            url = url + params
        end
        responseData = (RestClient.get(url))
        return JSON.parse(responseData)
    end 
end