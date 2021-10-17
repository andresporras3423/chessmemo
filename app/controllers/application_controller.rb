include ActionController::Cookies
class ApplicationController < ActionController::API
    def restrict_access
        begin
            if cookies[:player_id]
              @player = Player.find(cookies[:player_id])
            else
              render json: { "error": 'you must be logged to do this action' }, status: :unauthorized
            end
        rescue => exception
            render json: { "error": 'wrong data provided' }, status: :unauthorized
        end
    end
end
