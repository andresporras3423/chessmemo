class UniqueCombination < ActiveRecord::Migration[6.1]
  def change
    add_index :positions, [:pieces_position, :black_long_castling, :black_short_castling, :white_long_castling, :white_short_castling, :last_movement], 
    :unique => true,
    name: "unique_combined_in_positions"
  end
end
