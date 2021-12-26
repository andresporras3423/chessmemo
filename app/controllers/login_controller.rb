require "jwt"

class LoginController < ApplicationController
  before_action :restrict_access, only: [:get, :delete]

  def create
    player = Player.find_by_email(params[:email])
    if player&.authenticate(params[:password])
      token = JWT.encode({ id: player.id }, Rails.application.credentials.dig(:secret_token), "HS256")
      render json: { "token": token }, status: :accepted
    else
      render json: {"error": player.nil? ? "email not found" : "password incorrect"}, status: :unprocessable_entity 
    end
  end

  def get
    render json: { "current player": @@player.email }, status: :ok
  end

  def delete
    cookies[:player_id] = nil
    render json: { "status": "successfully unlogged" }, status: :ok
  end
end
