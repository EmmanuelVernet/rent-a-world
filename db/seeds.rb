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
Activity.destroy_all
Amenity.destroy_all
User.destroy_all
World.destroy_all

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

admin = User.find_or_create_by!(email: "test@test.com") do |user|
  user.first_name = "Benevolent"
  user.last_name = "Dictator"
  user.role = :admin # Or :admin if he manages listings
  user.address = "Carfax Abbey, Room 7, Paris" # A bit ironic ;)
  user.phone = "+33 22 6666 0000"
  user.user_description = "Renowned benevolent dictator of this app. Seeking to build battle station for cheap."
  user.password = "123456" # Consider a more secure default in production
end
# More interesting users for the fantasy world
user1 = User.find_or_create_by!(email: "van.helsing@monsterhunter.net") do |user|
  user.first_name = "Abraham"
  user.last_name = "Van Helsing"
  user.role = :renter # Or :admin if he manages listings
  user.address = "Carfax Abbey, Room 7, London" # A bit ironic ;)
  user.phone = "+44 20 7946 0000"
  user.user_description = "Renowned vampire hunter, expert in ancient lore and supernatural threats. Seeking temporary lodgings between expeditions."
  user.password = "stakesandgarlic" # Consider a more secure default in production
end

user2 = User.find_or_create_by!(email: "merlin@camelot.gov.uk") do |user|
  user.first_name = "Merlin"
  user.last_name = "Ambrosius"
  user.role = :renter # Perhaps Merlin manages magical locations
  user.address = "The Crystal Cave, Avalon"
  user.phone = "+44 163 200 0001" # A mystical sounding number
  user.user_description = "Legendary sorcerer and advisor. Occasionally requires a quiet retreat for arcane research and contemplation. Familiar with various enchanted realms."
  user.password = "enchantment123"
end

user3 = User.find_or_create_by!(email: "ciri@witchermail.net") do |user|
  user.first_name = "Cirilla"
  user.last_name = "Fiona Elen Riannon"
  user.role = :renter # A traveler seeking temporary stays
  user.address = "Currently traversing the Continent" # More fitting for her
  user.phone = "N/A (magical communication only)"
  user.user_description = "Witcher trainee with Elder Blood. Possesses unique abilities and knowledge of various dimensions. Needs secure and discreet lodging."
  user.password = "swallow123"
end

user4 = User.find_or_create_by!(email: "smaug@lonelymountain.com") do |user|
  user.first_name = "Smaug"
  user.last_name = "The Golden"
  user.role = :renter # Could potentially rent out his hoard...
  user.address = "The Lonely Mountain, Erebor"
  user.phone = "(+Middle Earth) 011-789-DRAGON" # A bit whimsical
  user.user_description = "Magnificent and powerful dragon with a vast hoard of treasure. Seeking secure storage or temporary relocation options for said hoard. Fireproof accommodations preferred."
  user.password = "goldenscales"
end

user5 = User.find_or_create_by!(email: "galadriel@lothlorien.el") do |user|
  user.first_name = "Galadriel"
  user.last_name = "of Lothlórien"
  user.role = :renter # Might manage elven sanctuaries
  user.address = "Caras Galadhon, Lothlórien"
  user.phone = "(+Middle Earth) 011-353-MIRROR"
  user.user_description = "Lady of the Galadhrim, possessor of Nenya. Offers wisdom and occasionally seeks serene locations for reflection and foresight."
  user.password = "elvenwisdom"
end

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
  },
  {
    user: user1,
    title: "Mystic Sky Gardens",
    category: "Floating Gardens",
    place: "Cloudhaven",
    price: 170.0,
    description: "Explore the floating gardens suspended in the sky, where rare plants bloom and creatures of the air guide your journey.",
    capacity: 8,
    latitude: 51.1657,
    longitude: 10.4515
  },
  {
    user: user2,
    title: "Vampire’s Castle Adventure",
    category: "Haunted Mansion",
    place: "Bloodthorn Keep",
    price: 210.0,
    description: "Step into a gothic castle ruled by a mysterious vampire lord. Uncover dark secrets while avoiding deadly traps.",
    capacity: 6,
    latitude: 47.6062,
    longitude: -122.3321
  },
  {
    user: user3,
    title: "Misty Marsh Expedition",
    category: "Swamp Realm",
    place: "Whispering Bog",
    price: 130.0,
    description: "Venture through the misty swamps filled with mysterious creatures and ancient ruins. Uncover hidden treasures while braving the fog.",
    capacity: 10,
    latitude: 45.4215,
    longitude: -75.6972
  },
  {
    user: user5,
    title: "Celestial Harvest Festival",
    category: "Festival",
    place: "Starlight Meadows",
    price: 100.0,
    description: "Join the celestial harvest festival under the stars. Celebrate with otherworldly creatures, magical music, and feasts from the sky.",
    capacity: 20,
    latitude: 39.9042,
    longitude: 116.4074
  },
  {
    user: user5,
    title: "Elemental Trials",
    category: "Elemental Realms",
    place: "Elementis",
    price: 250.0,
    description: "Test your strength across the four elemental realms—fire, water, earth, and air—each offering unique challenges and untold riches.",
    capacity: 5,
    latitude: 34.0522,
    longitude: -118.2437
  },
  {
    user: user1,
    title: "Frozen Enclave",
    category: "Ice Kingdom",
    place: "Glacier Hold",
    price: 190.0,
    description: "Journey through the ice-covered realm of Glacier Hold. Meet frost giants, explore hidden ice caves, and discover the frozen treasures of old.",
    capacity: 12,
    latitude: 64.9631,
    longitude: -19.0208
  },
  {
    user: user2,
    title: "The Phantom Islands",
    category: "Ghostly Isles",
    place: "Isles of the Lost",
    price: 220.0,
    description: "Explore the mysterious Phantom Islands, where the spirits of ancient sailors roam. Encounter ghostly apparitions and uncover forgotten shipwrecks.",
    capacity: 7,
    latitude: 35.6895,
    longitude: 139.6917
  },
  {
    user: user3,
    title: "Witch’s Hollow Mystery",
    category: "Dark Forest",
    place: "Hallowbrook",
    price: 150.0,
    description: "Wander through the eerie woods of Hallowbrook, solving ancient mysteries and encountering dark witches that wield strange magics.",
    capacity: 10,
    latitude: 38.9072,
    longitude: -77.0369
  },
  {
    user: user4,
    title: "Crystal Cavern Adventure",
    category: "Gemstone Realm",
    place: "Glimmerstone Caverns",
    price: 180.0,
    description: "Venture deep into the Glimmerstone Caverns, where the walls shine with hidden gems. Seek out ancient relics and explore breathtaking crystal formations.",
    capacity: 6,
    latitude: 42.3601,
    longitude: -71.0589
  },
  {
    user: user5,
    title: "Thunderstorm Safari",
    category: "Storm Plains",
    place: "Vortex Plains",
    price: 160.0,
    description: "Witness the raw power of nature in the Vortex Plains, where storms rage constantly. Chase thunderclouds and discover storm-chasing beasts.",
    capacity: 9,
    latitude: -22.9068,
    longitude: -43.1729
  }
]

worlds.each do |world|
  World.create!(world)
end

puts "#{World.count} worlds created!"

puts "assigning activities to worlds..."

worlds = World.all
activities = Activity.all

# Assign random activities (between 1 to 5 activities) to each world
worlds.each do |world|
  random_activities = activities.sample(rand(2..4)) # Randomly pick between 1 and 5 activities
  random_activities.each do |activity|
    # join table for activities and worlds
    world.activities << activity unless world.activities.include?(activity)
  end
end

puts "#{worlds.sum { |world| world.activities.count }} activities assigned to worlds!"

puts "assigning amenities to worlds..."

worlds = World.all
amenities = Amenity.all

# Assign random amenities (between 1 to 5 amenities) to each world
worlds.each do |world|
  random_amenities = amenities.sample(rand(2..3)) # Randomly pick amenities
  random_amenities.each do |amenitiy|
    # join table for amenities and worlds
    world.amenities << amenitiy unless world.amenities.include?(amenitiy)
  end
end

puts "#{worlds.sum { |world| world.amenities.count }} amenities assigned to worlds!"

# puts "creating bookings..."

# Example
# Booking.new(
# rent-a-world(dev)*   user_id: 7,
# rent-a-world(dev)*   world_id: 21,
# rent-a-world(dev)*   status: "pending",
# rent-a-world(dev)*   start_date: Date.new(2025, 6, 1),
# rent-a-world(dev)*   end_date: Date.new(2025, 12, 1)
# rent-a-world(dev)> )

# Add some random bookings for users in random worlds
# users = User.all
# worlds = World.all

# users.each do |user|
#   rand(1..3).times do # each user can have between 1 to 3 bookings
#     world = worlds.sample # randomly pick a world
#     Booking.create!(user: user, world: world, start_date: Faker::Date.forward(days: 30), end_date: Faker::Date.forward(days: 60), status: ["booked", "pending", "cancelled"].sample)
#   end
# end

# puts "#{Booking.count} bookings created!"

# puts "creating reviews..."

# # Add some random reviews for users in random worlds
# users.each do |user|
#   worlds.sample(3).each do |world| # each user can review up to 3 worlds
#     Review.create!(user: user, world: world, stars: rand(1..5), comment: Faker::Lorem.sentence)
#   end
# end

# puts "#{Review.count} reviews created!"
