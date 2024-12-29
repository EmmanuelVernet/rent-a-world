# create_table "bookings", force: :cascade do |t|
#   t.bigint "user_id", null: false
#   t.bigint "world_id", null: false
#   t.string "status"
#   t.date "start_date"
#   t.date "end_date"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["user_id"], name: "index_bookings_on_user_id"
#   t.index ["world_id"], name: "index_bookings_on_world_id"
# end

# create_table "reviews", force: :cascade do |t|
#   t.bigint "user_id", null: false
#   t.bigint "world_id", null: false
#   t.text "comment"
#   t.integer "stars", default: 0
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["user_id"], name: "index_reviews_on_user_id"
#   t.index ["world_id"], name: "index_reviews_on_world_id"
# end


# TAGS
tag_list = [ "fantasy", "horror", "space", "video game", "magical realm", "sky", "ruins", "time travel", "shadow" ]

tag_list.each do |tag|
  Tag.create!(name: tag)
end

# create_table "users", force: :cascade do |t|
#   t.string "email", default: "", null: false
#   t.string "encrypted_password", default: "", null: false
#   t.string "reset_password_token"
#   t.datetime "reset_password_sent_at"
#   t.datetime "remember_created_at"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["email"], name: "index_users_on_email", unique: true
#   t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
# end

# USERS
user1 = User.create!(email: "test1@test.com", password: "123456")
user2 = User.create!(email: "test2@test.com", password: "123456")
user3 = User.create!(email: "test3@test.com", password: "123456")
user4 = User.create!(email: "test4@test.com", password: "123456")
user5 = User.create!(email: "test5@test.com", password: "123456")


# create_table "world_tags", force: :cascade do |t|
#   t.bigint "world_id", null: false
#   t.bigint "tag_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["tag_id"], name: "index_world_tags_on_tag_id"
#   t.index ["world_id"], name: "index_world_tags_on_world_id"
# end

# create_table "worlds", force: :cascade do |t|
#   t.bigint "user_id", null: false
#   t.string "title"
#   t.string "category"
#   t.string "place"
#   t.float "price"
#   t.text "description"
#   t.integer "capacity"
#   t.float "latitude"
#   t.float "longitude"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["user_id"], name: "index_worlds_on_user_id"
# end
