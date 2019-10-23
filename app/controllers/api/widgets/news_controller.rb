class Api::Widgets::NewsController < Api::WidgetsController
  before_action :authorize_access_request!
  def index
    @newsData = call_api('news')
    data = {
      :newsData => @newsData,
    }
    respond_to do |format|
      format.json  { render :json => data }
    end
  end
end
