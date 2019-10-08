class SigninController < ApplicationController
  before_action :authorize_access_request!, only: [:destroy]
  skip_before_action :verify_authenticity_token
  def create
    user = User.find_by(username: params[:username])
    if user
      if user.authenticate(params[:password])
        payload  = { user_id: user.id }
        session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
        # tokens = session.login
        # response.set_cookie(JWTSessions.access_cookie,
        #                     value: tokens[:access],
        #                     httponly: true,
        #                     secure: Rails.env.production?)

        # render json: { csrf: tokens[:csrf] }
        render json: session.login
      else
        not_found
      end
    else
      not_found
    end
  end
  def destroy
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    render json: :ok
  end
  def not_found
    render json: { error: 'Cannont find such username/password combination' }, status: :not_found
  end
end