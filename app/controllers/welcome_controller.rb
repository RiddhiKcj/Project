class WelcomeController < ApplicationController
  def index
    @users = User.all
    @user = current_user
    @globalApi = Globalapi.all
  end
end
