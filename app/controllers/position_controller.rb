class PositionController < ApplicationController
    before_action :restrict_access
      def get
        current_player_config = Config.find_by_player_id(@player.id)
        query = ActiveRecord::Base.sanitize_sql_array(["difficulties.id=?", current_player_config.difficulty_id])
        questions = Config.find_by_player_id(@player.id).questions
        positions = Position.joins("""
            INNER JOIN difficulties ON 
            difficulties.min_pieces<=positions.total_black_pieces+positions.total_white_pieces
            and difficulties.max_pieces>=positions.total_black_pieces+positions.total_white_pieces
            """).where(query).limit(current_player_config.questions)
        render json: positions, status: :ok
      end
  end