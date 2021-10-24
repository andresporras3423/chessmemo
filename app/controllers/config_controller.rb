class ConfigController < ApplicationController
  before_action :restrict_access

  def get
    render json: Config.find_by_player_id(@player.id), status: :ok
  end

  def put
    config = Config.find_by_player_id(@player.id)
    config.difficulty_id = params[:difficulty_id]
    config.questions = params[:questions]
    if config.valid?
        config.save
        render json: Config.find_by_player_id(@player.id), status: :ok
    else
        render json: config.errors.messages, status: :conflict
    end
  end
end
