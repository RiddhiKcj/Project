class Api::Admin::Users::UsersController < AdminController
    before_action :authenticate_user!
    skip_before_action :authenticate_user!, only: :create
    before_action :load_user
  
    def create
      @user = User.create({
          username: params["username"],
          email: params["email"],
          password: params["password"]
        })
  
      if @user.errors.any?
        render json: {success: false, errors: @user.errors.messages}.to_json, status: 422
      else
        redirect_to root_path
      end
    end
  
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
        redirect_to root_path
      else
        render json: {success: false, errors: @user.errors.messages}.to_json, status: 422
      end
    end
  
    def destroy
      if @user.destroy
        head 200
      else
        render json: {success: false, errors: @user.errors.messages}.to_json, status: 422
      end
    end
  
    private
  
      def user_params
        params.require(:user).permit(
          :username,
          :email,
          :password,
          :password_confirmation
        )
      end
  
      def load_user
        @user = User.find(params[:id])
      end
  
  end
  