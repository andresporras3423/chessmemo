class PositionController < ApplicationController
  before_action :restrict_access

  def get
    current_player_config = Config.find_by_player_id(@@player.id)
    query = ActiveRecord::Base.sanitize_sql_array(["difficulties.id=?", current_player_config.difficulty_id])
    questions = Config.find_by_player_id(@@player.id).questions
    positions = Position.joins("""
            INNER JOIN difficulties ON 
            (difficulties.id=positions.total_black_pieces and positions.next_player='black')
            or (difficulties.id=positions.total_white_pieces and positions.next_player='white')
            """).where(query).order('RANDOM()').limit(current_player_config.questions)
            # byebug
            # INNER JOIN difficulties ON 
            # difficulties.min_pieces<=positions.total_black_pieces+positions.total_white_pieces
            # and difficulties.max_pieces>=positions.total_black_pieces+positions.total_white_pieces
    render json: {"positions": positions, "difficulty_id": current_player_config.difficulty_id}, status: :ok
  end
end
