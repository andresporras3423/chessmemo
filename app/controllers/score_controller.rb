class ScoreController < ApplicationController
  before_action :restrict_access

  def create
    config = Config.find_by_player_id(@@player.id)
    score = Score.new(difficulty_id: config.difficulty_id,
        questions: config.questions,
        corrects: params[:corrects],
        seconds: params[:seconds],
        player_id: @@player.id)
    if score.valid?
        score.save
        global_sql = query = ActiveRecord::Base.sanitize_sql_array(["""
          select num from 
              (select id, ROW_NUMBER() OVER(partition by questions, difficulty_id order by corrects desc, seconds) as num 
              from scores) as sorted where id=?
          """, score.id])
        global_position = ActiveRecord::Base.connection.execute(global_sql).first
        personal_sql = query = ActiveRecord::Base.sanitize_sql_array(["""
          select num from 
              (select id, ROW_NUMBER() OVER(partition by questions, difficulty_id, player_id order by corrects desc, seconds) as num 
              from scores) as sorted where id=?
          """, score.id])
        personal_position = ActiveRecord::Base.connection.execute(personal_sql).first
        render json: {"global_position": global_position["num"], "personal_position": personal_position["num"]}, status: :ok
    else
      puts "CONFLICT: #{score.errors.messages}"
        render json: score.errors.messages, status: :conflict
    end
  end

  def best_global # best global scores, current config
    config = Config.find_by_player_id(@@player.id)
    render json: Score.where(questions: config.questions, difficulty_id: config.difficulty_id).order("corrects desc, seconds").limit(10), status: :ok
  end

  def best_personal # best personal scores, current config
    # config = Config.find_by_player_id(@@player.id)
    query_sql = query = ActiveRecord::Base.sanitize_sql_array(["""
      select sc.questions, sc.corrects, sc.seconds, sc.created_at from scores as sc
      inner join configs as co
      on sc.player_id=co.player_id and sc.questions=co.questions and sc.difficulty_id=co.difficulty_id
      where sc.player_id=?
      order by sc.corrects desc, sc.seconds
      limit 10
      """, @@player.id])
      best_positions = ActiveRecord::Base.connection.execute(query_sql)
    render json: best_positions, status: :ok
  end

  def recent_personal # recent personal scores, any config
    render json: Score.where(player_id: @@player.id).order("id desc").limit(10), status: :ok
  end

  def recent_config # recent personal scores, current config
    config = Config.find_by_player_id(@@player.id)
    render json: Score.where(player_id: @@player.id, questions: config.questions, difficulty_id: config.difficulty_id).order("id desc").limit(10), status: :ok
  end
end
