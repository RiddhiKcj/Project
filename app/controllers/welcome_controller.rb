class WelcomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
    @user = current_user
    @globalApi = Globalapi.all
    data = {
      :user => @user,
      :users => @users,
      :globalApi => @globalApi
    }
    respond_to do |format|
      format.json  { render :json => data }
    end
  end
end
