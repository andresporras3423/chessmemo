require "jwt"

class ApplicationController < ActionController::API
    def restrict_access
      begin
        decoded_token = JWT.decode(request.headers["token"], Rails.application.credentials.dig(:secret_token), false, { algorithm: 'HS256' })
        @@player = Player.find(decoded_token[0]["id"])
        head :unauthorized unless @@player
      rescue => error
        head :unauthorized
      end
    end
end
