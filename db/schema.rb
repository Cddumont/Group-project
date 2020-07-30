# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_30_204302) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "downvotes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "review_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_downvotes_on_review_id"
    t.index ["user_id"], name: "index_downvotes_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating", null: false
    t.string "body"
    t.string "title"
    t.bigint "videogame_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["videogame_id"], name: "index_reviews_on_videogame_id"
  end

  create_table "upvotes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "review_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_upvotes_on_review_id"
    t.index ["user_id"], name: "index_upvotes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "username", null: false
    t.string "profile_photo"
    t.string "role", default: "member", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "videogames", force: :cascade do |t|
    t.string "name", null: false
    t.string "release_year"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
  end

end
