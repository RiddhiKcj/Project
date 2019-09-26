class Api::NewsController < ApplicationController
  def index
    newsApi = Globalapi.find_by name: 'news'
    key = newsApi.api
    # url format = '...apiKey='#{key}
    url = newsApi.url + key
    responseData = (RestClient.get(url))
    @newsData = JSON.parse(responseData)
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => responseData }
    end
  end
end
