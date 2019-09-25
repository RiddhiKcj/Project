module ApiIntegrators
  class NewsController < ApplicationController
    def index
      newsApi = Globalapi.find_by name: 'news'
      url = newsApi.url
      key = newsApi.key
      @newsData = ApiCalls.newCall(url)
    end
  end
end