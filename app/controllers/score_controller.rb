class ScoreController < ApplicationController
  before_action :restrict_access

  def create
    score = Score.new(difficulty_id: params[:difficulty_id],
        questions: params[:questions],
        corrects: params[:corrects],
        seconds: params[:seconds],
        player_id: @@player.id)
    if score.valid?
        score.save
        render json: Config.find_by_player_id(@@player.id), status: :ok
    else
        render json: score.errors.messages, status: :conflict
    end
  end

  def best_global # best global scores, current config
    config = Config.find_by_player_id(@@player.id)
    render json: Score.where(questions: config.questions, difficulty_id: config.difficulty_id).order("corrects desc, seconds").limit(10), status: :ok
  end

  def best_personal # best personal scores, current config
    config = Config.find_by_player_id(@@player.id)
    render json: Score.where(player_id: @@player.id, questions: config.questions, difficulty_id: config.difficulty_id).order("corrects desc, seconds").limit(10), status: :ok
  end

  def recent_personal # recent personal scores, any config
    render json: Score.where(player_id: @@player.id).order("id desc").limit(10), status: :ok
  end

  def recent_config # recent personal scores, current config
    config = Config.find_by_player_id(@@player.id)
    render json: Score.where(player_id: @@player.id, questions: config.questions, difficulty_id: config.difficulty_id).order("id desc").limit(10), status: :ok
  end
end
