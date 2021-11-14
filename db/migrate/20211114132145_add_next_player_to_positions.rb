class AddNextPlayerToPositions < ActiveRecord::Migration[6.1]
  def change
    add_column :positions, :next_player, :string
  end
end
