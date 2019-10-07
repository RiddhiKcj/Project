class Api::SelectedwidgetsController < ApplicationController
    before_action :authorize_access_request!
    def create
        puts params
        @user = User.find(params[:user_id])
        if params["_json"].present?
            @user.selectedwidgets.destroy_all
        end
        params["_json"].each do |api|
            @user.selectedwidgets.create(name: api)
        end
        puts @user.selectedwidgets.all
    end
end
