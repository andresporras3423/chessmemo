class LoginController < ApplicationController
    def create
        player = Player.find_by_email(params[:email])
        if player&.authenticate(params[:password])
          cookies[:player_id] = player.id  
          player.record_signup
          player.save
          render json: player.as_json(only: %i[id email name remember_token]), status: :created
        else
          render json: {"error": 401}, status: :unauthorized
        end
      end
end
