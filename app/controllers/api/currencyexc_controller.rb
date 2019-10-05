class Api::CurrencyexcController < ApplicationController
  before_action :authorize_access_request! 
  def index
      currencyexcApi = Widget.find_by name: 'currencyexc'
      key = currencyexcApi.apikey
      # FORMAT url = '...apiKey='#{key}
      url = currencyexcApi.url + key
      responseData = (RestClient.get(url))
      puts responseData
      @currencyexcData = JSON.parse(responseData)
      data = {
        :currencyexcData => @currencyexcData,
      }
      respond_to do |format|
        format.json  { render :json => data }
      end
    end
  end
  