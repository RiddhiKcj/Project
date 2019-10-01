class Api::Admin::Widgets::CurrencyexcController < AdminController
    def index
      currencyexcApi = Globalapi.find_by name: 'currencyexc'
      key = currencyexcApi.api
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
  