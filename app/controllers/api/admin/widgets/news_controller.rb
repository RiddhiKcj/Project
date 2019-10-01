class Api::Admin::Widgets::NewsController < AdminController
  def index
    newsApi = Globalapi.find_by name: 'news'
    key = newsApi.api
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