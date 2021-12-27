require_relative "../../lib/positions"
require_relative "../../lib/board_data"

class Position < ApplicationRecord
  def self.create_positions(save_board=true, repetitions=1)
    initialize_board(save_board, repetitions)
    start_game
  end

  def self.initialize_board(save_, max_games_ = 1)
    @save_in_database = save_
    @positions = Positions.new
    @boards = []
    @total_games = 0
    @max_games = max_games_
  end

  def self.start_game
    @positions = Positions.new
    @positions.set_initial_board
    @boards = []
    next_white_move
  end

  def self.next_white_move
    movements = @positions.available_white_moves.to_a
    return if (is_it_game_over(movements.length))
    add_recent_board(movements.length)
    print_last_board_info
    rnd = rand(movements.length)
    last_movement = movements[rnd]
    @positions.update_board_details_after_white_move(last_movement)
    @positions.set_initial_board
    next_black_move
  end

  def self.next_black_move
    movements = @positions.available_black_moves.to_a
    return if (is_it_game_over(movements.length))
    add_recent_board(movements.length)
    print_last_board_info
    rnd = rand(movements.length)
    last_movement = movements[rnd]
    @positions.update_board_details_after_black_move(last_movement)
    @positions.set_initial_board
    next_white_move
  end

  def self.give_current_board
    current_board = ""
    @positions.cells.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        current_board += cell[0...2]
        current_board += "," if (j < 7)
      end
      current_board += "*" if (i < 7)
    end
    current_board
  end

  def self.is_it_game_over(total_movements)
    if ((total_movements == 0) || (@positions.black_pieces.keys.length + @positions.white_pieces.keys.length == 2) || (@positions.checkmate_still_possible? == false))
      add_recent_board(total_movements) if (total_movements == 0)
      activate_repeat
      return true
    end
    false
  end

  def self.activate_repeat
    @total_games += 1
    start_game if @total_games < @max_games
  end

  def self.add_recent_board(total_movements)
    bd = BoardData.new(give_current_board,
                       @positions.black_pieces.keys.length,
                       @positions.white_pieces.keys.length,
                       @positions.black_long_castling,
                       @positions.black_short_castling,
                       @positions.white_long_castling,
                       @positions.white_short_castling,
                       last_movement_reduced,
                       total_movements,
                       [",", "b"].include?(last_movement_reduced[0]) ? "white" : "black")
    save_position(bd) if (@save_in_database)
    @boards.push(bd)
  end

  def self.save_position(board)
      begin
        p = Position.new(pieces_position: board.pieces_position, 
          total_black_pieces: board.total_black_pieces, 
          total_white_pieces: board.total_white_pieces, 
          black_long_castling: board.black_long_castling, 
          black_short_castling: board.black_short_castling, 
          white_long_castling: board.white_long_castling, 
          white_short_castling: board.white_short_castling, 
          last_movement: board.last_movement, 
          movements_available: board.movements_available, 
          next_player: board.next_player)
          p.save
      rescue => e
        puts e.message
      end
  end

  def self.last_movement_reduced
    @positions.last_movement.split(",", -1).map { |pos| pos[0...2] }.join(",")
  end

  def self.print_last_board_info
    puts "turn: #{(@boards.length + 1) / 2}"
    puts @boards.last.print_info
  end
end
