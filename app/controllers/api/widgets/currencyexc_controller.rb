class Api::Widgets::CurrencyexcController < Api::WidgetsController
  before_action :authorize_access_request! 
  def index
      @currencyexcData = call_api('currencyexc')
      data = {
        :currencyexcData => @currencyexcData,
      }
      respond_to do |format|
        format.json  { render :json => data }
      end
    end
  end
  