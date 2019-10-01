class Api::Admin::WelcomeController < AdminController
  def index
    @user = current_user
    @widgets = Globalapi.all
    @selectedWidgets = []
    @user.myapis.each do |api|
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
