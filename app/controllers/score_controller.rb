class ScoreController < ApplicationController
  before_action :restrict_access

  def create
    score = Score.new(difficulty_id: params[:difficulty_id],
        questions: params[:questions],
        corrects: params[:corrects],
        seconds: params[:seconds],
        player_id: @player.id)
    if score.valid?
        render json: Config.find_by_player_id(@player.id), status: :ok
    else
        render json: score.errors.messages, status: :conflict
    end
  end

  def put
  end
end
