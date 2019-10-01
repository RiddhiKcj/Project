class Api::Admin::User::SelectedWidgets::MyapisController < Api::Admin::Users::UsersController
    def create
        puts params
        @user = User.find(params[:user_id])
        if params["_json"].present?
            @user.myapis.destroy_all
        end
        params["_json"].each do |api|
            @user.myapis.create(name: api)
        end
        puts @user.myapis.all
    end
end
