class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :authenticate_user!
	layout :layout_by_resource

	def extract_ip_from(request)
		if request.remote_ip == '::1' || request.remote_ip == '127.0.0.1'
			"111.93.220.154"
		else
			request.remote_ip
		end
	end

	protected
	def layout_by_resource
		user_signed_in? ? "application" : "index_layout"
	end
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
	end

end

