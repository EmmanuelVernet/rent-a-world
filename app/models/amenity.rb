class Amenity < ApplicationRecord
  has_many :world_amenities, dependent: :destroy
  has_many :worlds, through: :world_amenities

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { minimum: 5 }
end
