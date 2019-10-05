class WelcomeController < ApplicationController
  before_action :authorize_access_request!
  def index
    @user = current_user
    @widgets = Widget.all
    @selectedWidgets = []
    @user.selectedwidgets.each do |api|
      @selectedWidgets.push(api.name)
    end
    data = {
      :user => @user,
      :widgets => @widgets,
      :selectedWidgets => @selectedWidgets
    }
    respond_to do |format|
      format.json  { render :json => data }
    end
  end
end
