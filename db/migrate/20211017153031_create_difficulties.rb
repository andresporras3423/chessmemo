class CreateDifficulties < ActiveRecord::Migration[6.1]
  def change
    create_table :difficulties do |t|
      t.string :difficulty_name
      t.integer :min_pieces
      t.integer :max_pieces

      t.timestamps
    end
  end
end
