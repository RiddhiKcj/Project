class RefreshController < ApplicationController
    before_action :authorize_refresh_request!
  
    def create
        session = JWTSessions::Session.new(payload: access_payload)
        tokens = session.refresh_by_access_payload do
        raise JWTSessions::Errors::Unauthorized, 'Malicious activity detected'
        end
        response.set_cookie(JWTSessions.access_cookie,
                            value: tokens[:access],
                            httponly: true,
                            secure: Rails.env.production?)

        # render json: { csrf: tokens[:csrf] }
        render json: session.refresh(found_token)
    end

    def access_payload
        build_access_payload_based_on_refresh(payload)
    end
  end