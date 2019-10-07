class Api::UsersController < ApplicationController
  # before_action :authorize_by_access_header!
    def update
      if params["id"] == params["user_id"]
        @user = User.find(params["id"])
        if params["password"].blank?
          user = {
            username: params["username"],
            email: params["email"]
          }
        else
          user = {
            username: params["username"],
            email: params["email"],
            password: params["password"]
          }
        end
        if @user.update_attributes(user)
          render json: {success: true}.to_json
        else
          render json: {success: false, errors: @user.errors.messages}.to_json, status: 422
        end
      else
        render json: {success: false, errors: 'You are not authorized'}.to_json, status: 422
      end
    end
  
  end
  