class Api::SelectedwidgetsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        puts params
        @user = User.find(params[:user_id])
        @user.selectedwidgets.destroy_all
        if params["_json"].present?
            params["_json"].each do |api|
                @user.selectedwidgets.create(name: api)
            end
        end
        puts @user.selectedwidgets.all
    end
end
