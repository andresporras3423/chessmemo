# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_17_154036) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "configs", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "difficulty_id", null: false
    t.integer "questions"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["difficulty_id"], name: "index_configs_on_difficulty_id"
    t.index ["player_id"], name: "index_configs_on_player_id"
  end

  create_table "difficulties", force: :cascade do |t|
    t.string "difficulty_name"
    t.integer "min_pieces"
    t.integer "max_pieces"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.string "remember_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "positions", force: :cascade do |t|
    t.string "pieces_position"
    t.integer "total_black_pieces"
    t.integer "total_white_pieces"
    t.boolean "black_long_castling"
    t.boolean "black_short_castling"
    t.boolean "white_long_castling"
    t.boolean "white_short_castling"
    t.string "last_movement"
    t.integer "movements_available"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pieces_position", "black_long_castling", "black_short_castling", "white_long_castling", "white_short_castling", "last_movement"], name: "unique_combined_in_positions", unique: true
  end

  create_table "scores", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "difficulty_id", null: false
    t.integer "questions"
    t.integer "corrects"
    t.integer "seconds"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["difficulty_id"], name: "index_scores_on_difficulty_id"
    t.index ["player_id"], name: "index_scores_on_player_id"
  end

  add_foreign_key "configs", "difficulties"
  add_foreign_key "configs", "players"
  add_foreign_key "scores", "difficulties"
  add_foreign_key "scores", "players"
end
