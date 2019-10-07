class ApplicationController < ActionController::Base
    protect_from_forgery prepend: true, with: :exception
	include JWTSessions::RailsAuthorization
	rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

	def index
		render template: 'application'
	end

	def current_user
		@current_user ||= User.find(payload['user_id'])
	end
	
	protected

	
	private

	def not_authorized
		render json: { error: 'Not authorized' }, status: :unauthorized
	end
end

