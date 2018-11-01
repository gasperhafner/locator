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

ActiveRecord::Schema.define(version: 20181101123150) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.geometry "polygon", limit: {:srid=>4326, :type=>"st_polygon"}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_cities_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "speed"
    t.datetime "time"
    t.string "provider"
    t.float "battery"
  end

  create_table "path_cities", force: :cascade do |t|
    t.bigint "path_id"
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_path_cities_on_city_id"
    t.index ["path_id"], name: "index_path_cities_on_path_id"
  end

  create_table "paths", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_paths_on_user_id"
  end

  create_table "push_logs", force: :cascade do |t|
    t.bigint "city_id"
    t.string "sender"
    t.string "receiver"
    t.string "title"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_push_logs_on_city_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "magic_link_token"
    t.datetime "magic_link_token_expiration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bullet_push_token"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "cities", "users"
  add_foreign_key "path_cities", "cities"
  add_foreign_key "path_cities", "paths"
  add_foreign_key "paths", "users"
  add_foreign_key "push_logs", "cities"
end
