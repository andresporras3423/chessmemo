class CreatePositions < ActiveRecord::Migration[6.1]
  def change
    create_table :positions do |t|
      t.string :pieces_position
      t.integer :total_black_pieces
      t.integer :total_white_pieces
      t.boolean :black_long_castling
      t.boolean :black_short_castling
      t.boolean :white_long_castling
      t.boolean :white_short_castling
      t.string :last_movement
      t.integer :movements_available

      t.timestamps
    end
  end
end
