class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?
	#layout :layout_by_resource
	layout :false
	respond_to :json
	def index
		render template: 'application'
	end

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
	end
	def layout_by_resource
		user_signed_in? ? false : "index_layout"
	end
end

