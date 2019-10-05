class Api::NewsController < ApplicationController
  before_action :authorize_access_request!
  def index
    newsApi = Widget.find_by name: 'news'
    key = newsApi.apikey
    # url format = '...apiKey='#{key}
    url = newsApi.url + key
    responseData = (RestClient.get(url))
    @newsData = JSON.parse(responseData)
    data = {
      :newsData => @newsData,
    }
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => data }
    end
  end
end
