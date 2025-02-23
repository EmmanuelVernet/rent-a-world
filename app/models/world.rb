class World < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many :world_activities, dependent: :destroy
  has_many :activities, through: :world_activities

  has_many :world_amenities, dependent: :destroy
  has_many :amenities, through: :world_amenities

  has_many :world_tags, dependent: :destroy
  has_many :tags, through: :world_tags

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true
  validates :place, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }
  validates :latitude, :longitude, numericality: true, allow_nil: true
end
