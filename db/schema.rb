ActiveRecord::Schema[8.0].define(version: 2025_02_22_215324) do
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
    t.index ["user_id"], name: "index_bookings_on_user_id"
    t.index ["world_id"], name: "index_bookings_on_world_id"
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
