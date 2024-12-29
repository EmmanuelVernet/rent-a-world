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
puts "destroying seeded data"
Tag.destroy_all
User.destroy_all
World.destroy_all

puts "data destroyed"

# TAGS
puts "creating tags"

tag_list = [ "fantasy", "horror", "space", "video game", "magical realm", "sky", "ruins", "time travel", "shadow" ]

tag_list.each do |tag|
  Tag.create!(name: tag)
end

puts "created #{Tag.count} tags"

# USERS
user1 = User.create!(email: "test1@test.com", password: "123456")
user2 = User.create!(email: "test2@test.com", password: "123456")
user3 = User.create!(email: "test3@test.com", password: "123456")
user4 = User.create!(email: "test4@test.com", password: "123456")
user5 = User.create!(email: "test5@test.com", password: "123456")


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

worlds = [
  {
    user: user1,
    title: "Mystic Glade Retreat",
    category: "Enchanted Forest",
    place: "Eldertree Woods",
    price: 120.0,
    description: "A serene escape deep within the heart of the enchanted forest. Bask under glowing mushrooms and listen to the songs of magical creatures.",
    capacity: 10,
    latitude: 34.0522,
    longitude: -118.2437
  },
  {
    user: user2,
    title: "Celestial Isles Adventure",
    category: "Sky City",
    place: "Isles of Ether",
    price: 200.0,
    description: "Hover high above the clouds in this magical sky city. Fly with griffins and dine in floating castles while marveling at breathtaking sunsets.",
    capacity: 5,
    latitude: 40.7128,
    longitude: -74.0060
  },
  {
    user: user3,
    title: "King’s Legacy Quest",
    category: "Mystical Castle",
    place: "Crimson Citadel",
    price: 150.0,
    description: "Embark on a heroic journey to uncover the lost secrets of the Crimson Citadel. Battle shadow knights and retrieve the Crown of Eternity.",
    capacity: 20,
    latitude: 51.5074,
    longitude: -0.1278
  },
  {
    user: user4,
    title: "Atlantis Explorer Package",
    category: "Underwater Kingdom",
    place: "Lost City of Atlantis",
    price: 180.0,
    description: "Dive into the crystal-clear depths and explore the ancient ruins of Atlantis. Encounter mermaids, underwater caves, and forgotten treasures.",
    capacity: 8,
    latitude: -25.2744,
    longitude: 133.7751
  },
  {
    user: user5,
    title: "Cursed Tomb Expedition",
    category: "Ancient Ruins",
    place: "Shadowfang Temple",
    price: 100.0,
    description: "For the bold and brave, this adventure takes you through cursed tombs filled with traps, treasures, and long-forgotten relics.",
    capacity: 12,
    latitude: 29.9792,
    longitude: 31.1342
  }
]
# Create worlds
worlds.each do |world|
  World.create!(world)
end
