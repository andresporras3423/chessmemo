class CreateConfigs < ActiveRecord::Migration[6.1]
  def change
    create_table :configs do |t|
      t.references :player, null: false, foreign_key: true
      t.references :difficulty, null: false, foreign_key: true
      t.integer :questions

      t.timestamps
    end
  end
end
