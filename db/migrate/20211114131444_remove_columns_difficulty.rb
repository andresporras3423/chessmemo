class RemoveColumnsDifficulty < ActiveRecord::Migration[6.1]
  def change
    remove_column :difficulties, :difficulty_name
    remove_column :difficulties, :min_pieces
    remove_column :difficulties, :max_pieces
  end
end
