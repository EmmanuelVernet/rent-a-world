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
Activity.destroy_all
Amenity.destroy_all

puts "data destroyed"

# TAGS
puts "creating tags..."

tag_list = [ "fantasy", "horror", "space", "video game", "magical realm", "sky", "ruins", "time travel", "shadow" ]

tag_list.each do |tag|
  Tag.create!(name: tag)
end

puts "created #{Tag.count} tags!"

# USERS
puts "creating users..."

user1 = User.create!(email: "test1@test.com", password: "123456")
user2 = User.create!(email: "test2@test.com", password: "123456")
user3 = User.create!(email: "test3@test.com", password: "123456")
user4 = User.create!(email: "test4@test.com", password: "123456")
user5 = User.create!(email: "test5@test.com", password: "123456")

puts "created #{User.count} users!"

# ACTIVITIES
puts "creating activities..."

activities = [
  { name: "Wyvern Racing", description: "Race wyverns through fiery skies.", difficulty_level: "Hard", duration: 120, price: 100 },
  { name: "Potion Brewing", description: "Learn the ancient art of potion brewing.", difficulty_level: "Medium", duration: 90, price: 50 },
  { name: "Treasure Hunting", description: "Search for hidden treasures in the ancient ruins.", difficulty_level: "Easy", duration: 180, price: 75 },
  { name: "Dragon Riding", description: "Learn to ride and control dragons in the wild.", difficulty_level: "Hard", duration: 150, price: 150 },
  { name: "Goblin Bounty Hunting", description: "Track down and capture rogue goblins.", difficulty_level: "Medium", duration: 180, price: 60 },
  { name: "Mermaid Singing", description: "Join the mermaids for an evening of underwater songs.", difficulty_level: "Easy", duration: 60, price: 30 },
  { name: "Dwarven Mining", description: "Dig deep into the mountains to uncover precious gems and metals.", difficulty_level: "Medium", duration: 240, price: 120 },
  { name: "Arcane Spellcasting", description: "Master the basic spells of the arcane arts.", difficulty_level: "Medium", duration: 120, price: 100 },
  { name: "Elven Archery", description: "Sharpen your skills with a bow and arrow in the Elven woods.", difficulty_level: "Medium", duration: 90, price: 75 },
  { name: "Mystic Herbology", description: "Collect rare and magical plants in the enchanted forest.", difficulty_level: "Easy", duration: 150, price: 40 },
  { name: "Phoenix Flight", description: "Fly on the back of a mythical Phoenix through the skies.", difficulty_level: "Hard", duration: 180, price: 200 },
  { name: "Unicorn Care", description: "Learn how to care for and groom magical unicorns.", difficulty_level: "Easy", duration: 90, price: 80 },
  { name: "Golem Construction", description: "Craft and animate a golem from clay and enchanted stones.", difficulty_level: "Hard", duration: 180, price: 250 },
  { name: "Time Manipulation Training", description: "Learn to bend the flow of time in your favor.", difficulty_level: "Hard", duration: 120, price: 500 },
  { name: "Basilisk Taming", description: "Tame the powerful basilisk, a creature of legends.", difficulty_level: "Hard", duration: 150, price: 350 },
  { name: "Fairy Light Harvesting", description: "Harvest the magical lights from the Fairy Queen's garden.", difficulty_level: "Easy", duration: 60, price: 45 },
  { name: "Vampire Hunting", description: "Track down and eliminate dangerous vampires from the kingdom.", difficulty_level: "Hard", duration: 180, price: 200 },
  { name: "Dragon Forge", description: "Create enchanted weapons at the Dragon Forge.", difficulty_level: "Medium", duration: 150, price: 130 },
  { name: "Witchcraft Mastery", description: "Master the art of witchcraft, potion-making, and hexes.", difficulty_level: "Hard", duration: 240, price: 180 }
]

activities.each do |activity|
  Activity.create!(activity)
end

puts "#{Activity.count} activities created!"

# AMENITIES
puts "creating amenities..."

amenities = [
  { name: "Enchanted Hot Springs", description: "Relax in the magical healing waters of the hot springs." },
  { name: "Floating Gardens", description: "Admire the gravity-defying beauty of the floating gardens." },
  { name: "Dragon Stables", description: "A safe and well-kept area for keeping and training dragons." },
  { name: "Mystic Forest", description: "Wander through the mysterious and magical forest filled with rare herbs and creatures." },
  { name: "Crystal Caves", description: "Explore the glowing, radiant caves filled with mystical crystals." },
  { name: "Moonlit Beach", description: "A beach where the waves shimmer under the full moon's light." },
  { name: "Elemental Shrine", description: "A sacred place where the four elements are worshiped and harnessed." },
  { name: "Wizard's Library", description: "An ancient library filled with knowledge of the arcane and forgotten lore." }
]

amenities.each do |amenity|
  Amenity.create!(amenity)
end

puts "#{Amenity.count} amenities created!"

# WORLDS
puts "creating worlds..."

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
  },
  {
    user: user1,
    title: "Draconic Highlands",
    category: "Mountain Range",
    place: "Dragonspire Peaks",
    price: 250.0,
    description: "Climb the towering Dragonspire Peaks, home to ancient dragons. Experience breathtaking views and discover hidden caves of untold treasures.",
    capacity: 6,
    latitude: 35.6895,
    longitude: 139.6917
  },
  {
    user: user2,
    title: "Feywild Escape",
    category: "Mystical Forest",
    place: "Glimmering Glen",
    price: 130.0,
    description: "Step into the Feywild, where the forest is alive with magic. Encounter mischievous fae, explore ancient groves, and seek out forgotten enchantments.",
    capacity: 15,
    latitude: 48.8566,
    longitude: 2.3522
  },
  {
    user: user3,
    title: "Tales of the Forgotten Kingdom",
    category: "Ancient Kingdom",
    place: "Ruins of Valoria",
    price: 175.0,
    description: "Venture into the forgotten kingdom of Valoria, where the ruins hold the secrets of an ancient civilization and powerful artifacts.",
    capacity: 10,
    latitude: 41.9028,
    longitude: 12.4964
  },
  {
    user: user4,
    title: "Eldritch Depths",
    category: "Caverns",
    place: "The Abyssal Trenches",
    price: 220.0,
    description: "Descend into the Eldritch Depths, where ancient beings lurk in the darkness. Uncover the mysteries of the deep, and avoid the perils that lie beneath.",
    capacity: 4,
    latitude: -33.8688,
    longitude: 151.2093
  },
  {
    user: user5,
    title: "Infernal Volcano Tour",
    category: "Volcanic Realm",
    place: "Mount Hellfire",
    price: 180.0,
    description: "Brave the molten landscape of Mount Hellfire. Experience the heat of active lava flows and uncover the secrets of the fire-breathing beasts that call it home.",
    capacity: 12,
    latitude: -19.9131,
    longitude: -43.9415
  }
]

worlds.each do |world|
  World.create!(world)
end

puts "#{World.count} worlds created!"
