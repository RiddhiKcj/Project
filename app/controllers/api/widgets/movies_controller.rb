class Api::Widgets::MoviesController < ApplicationController
  before_action :authorize_access_request!
  def index
    moviesApi = Widget.find_by name: 'movies'
    key = moviesApi.apikey
    params = '&language=en-US&region=IN&sort_by=popularity.desc&include_adult=true&include_video=false&page=1'
    url_for_hollywood = moviesApi.url + 'api_key=' + key + params + '&with_original_language=en'
    url_for_bollywood = moviesApi.url + 'api_key=' + key + params + '&primary_release_year=2019&with_original_language=hi'
    @hollywoodData = JSON.parse(RestClient.get(url_for_hollywood))
    @bollywoodData = JSON.parse(RestClient.get(url_for_bollywood))
    data = {
      :hollywoodData => @hollywoodData,
      :bollywoodData => @bollywoodData,
      :imageurl => 'https://image.tmdb.org/t/p/original/'
    }
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => data }
    end
  end
end