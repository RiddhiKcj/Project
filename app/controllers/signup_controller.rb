class SignupController < ActionController::Base
    def new
        redirect_to '/createuser'
    end
end