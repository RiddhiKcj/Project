class MyapisController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        @myapi = @user.myapis.create(params_check)
        @weatherData =
        apiUrl = '/'+@myapi.name+'/index'
        redirect_to apiUrl
    end
    private
    def params_check
        params.require(:myapi).permit(:name, :url, :api)
    end
end
