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

ActiveRecord::Schema[8.0].define(version: 2025_09_08_094944) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "difficulty_level"
    t.integer "duration"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "amenities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "world_id", null: false
    t.string "status"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "total_price"
    t.index ["user_id"], name: "index_bookings_on_user_id"
    t.index ["world_id"], name: "index_bookings_on_world_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "world_id", null: false
    t.bigint "sender_id", null: false
    t.bigint "recipient_id", null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_conversations_on_recipient_id"
    t.index ["sender_id", "recipient_id", "world_id"], name: "index_conversations_on_sender_id_and_recipient_id_and_world_id", unique: true
    t.index ["sender_id"], name: "index_conversations_on_sender_id"
    t.index ["world_id"], name: "index_conversations_on_world_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "world_id", null: false
    t.text "comment"
    t.integer "stars", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reviews_on_user_id"
    t.index ["world_id"], name: "index_reviews_on_world_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "phone"
    t.text "user_description"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "world_activities", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.bigint "world_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_world_activities_on_activity_id"
    t.index ["world_id"], name: "index_world_activities_on_world_id"
  end

  create_table "world_amenities", force: :cascade do |t|
    t.bigint "world_id", null: false
    t.bigint "amenity_id", null: false
    t.boolean "exclusive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amenity_id"], name: "index_world_amenities_on_amenity_id"
    t.index ["world_id"], name: "index_world_amenities_on_world_id"
  end

  create_table "world_tags", force: :cascade do |t|
    t.bigint "world_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_world_tags_on_tag_id"
    t.index ["world_id"], name: "index_world_tags_on_world_id"
  end

  create_table "worlds", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.string "category"
    t.string "place"
    t.float "price"
    t.text "description"
    t.integer "capacity"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_worlds_on_user_id"
  end

  add_foreign_key "bookings", "users"
  add_foreign_key "bookings", "worlds"
  add_foreign_key "conversations", "users", column: "recipient_id"
  add_foreign_key "conversations", "users", column: "sender_id"
  add_foreign_key "conversations", "worlds"
  add_foreign_key "reviews", "users"
  add_foreign_key "reviews", "worlds"
  add_foreign_key "world_activities", "activities"
  add_foreign_key "world_activities", "worlds"
  add_foreign_key "world_amenities", "amenities"
  add_foreign_key "world_amenities", "worlds"
  add_foreign_key "world_tags", "tags"
  add_foreign_key "world_tags", "worlds"
  add_foreign_key "worlds", "users"
end
