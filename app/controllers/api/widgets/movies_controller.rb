class Api::Widgets::MoviesController < Api::WidgetsController
  before_action :authorize_access_request!
  def index
    params = '&language=en-US&region=IN&sort_by=popularity.desc&include_adult=true&include_video=false&page=1'
    params_for_hollywood = params + '&with_original_language=en'
    params_for_bollywood = params + '&primary_release_year=2019&with_original_language=hi'
    @hollywoodData = call_api('movies' , params_for_hollywood)
    @bollywoodData = call_api('movies' , params_for_bollywood)
    data = {
      :hollywoodData => @hollywoodData,
      :bollywoodData => @bollywoodData,
      :imageurl => 'https://image.tmdb.org/t/p/original/'
    }
    respond_to do |format|
      format.json  { render :json => data }
    end
  end
end