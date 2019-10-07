class Api::UsersController < AdminController
    def update
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
        redirect_to api_home_path
      else
        render json: {success: false, errors: @user.errors.messages}.to_json, status: 422
      end
    end
  
  end
  