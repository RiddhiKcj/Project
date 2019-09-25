class NewsController < ApplicationController
  def index
    newsApi = Globalapi.find_by name: 'news'
    key = newsApi.api
    # url format = '...apiKey='#{key}
    url = newsApi.url + key
    @newsData = JSON.parse(RestClient.get(url))
  end
end
