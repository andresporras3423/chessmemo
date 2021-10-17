class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.references :player, null: false, foreign_key: true
      t.references :difficulty, null: false, foreign_key: true
      t.integer :questions
      t.integer :corrects
      t.integer :seconds

      t.timestamps
    end
  end
end
