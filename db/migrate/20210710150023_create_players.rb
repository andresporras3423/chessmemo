class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.string :remember_token

      t.timestamps
    end
  end
end
