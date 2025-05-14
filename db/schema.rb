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

ActiveRecord::Schema[7.1].define(version: 2025_05_14_061313) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmark_videos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "video_json", default: {}, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_bookmark_videos_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.integer "input_proficiency"
    t.integer "output_proficiency"
    t.string "english"
    t.string "japanese"
    t.string "source_video_url"
    t.date "reviewed_date"
    t.string "source_video_timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "flashcard_id", null: false
    t.string "context"
    t.index ["flashcard_id"], name: "index_cards_on_flashcard_id"
  end

  create_table "flashcards", force: :cascade do |t|
    t.string "title"
    t.boolean "shared"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.integer "input_target"
    t.integer "output_target"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_flashcards_on_user_id"
  end

  create_table "learning_factors", force: :cascade do |t|
    t.integer "input_step", default: 0
    t.integer "input_ease_factor", default: 250
    t.integer "input_interval", default: 0
    t.integer "output_step", default: 0
    t.integer "output_ease_factor", default: 250
    t.integer "output_interval", default: 0
    t.date "input_learned_at", default: -> { "CURRENT_DATE" }
    t.date "output_learned_at", default: -> { "CURRENT_DATE" }
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "card_id", null: false
    t.index ["card_id"], name: "index_learning_factors_on_card_id"
  end

  create_table "learning_histories", force: :cascade do |t|
    t.date "learned_date"
    t.integer "learned_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "bookmark_videos", "users"
  add_foreign_key "cards", "flashcards"
  add_foreign_key "flashcards", "users"
  add_foreign_key "learning_factors", "cards"
end
