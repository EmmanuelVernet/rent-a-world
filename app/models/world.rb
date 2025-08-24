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

  validates :title, presence: true
  validates :category, presence: true
  validates :place, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }
  validates :latitude, :longitude, numericality: true, allow_nil: true

  # PG SEARCH
  include PgSearch::Model

  pg_search_scope :search_by_fields,
    against: [:title, :category, :place, :price, :capacity],
    associated_against: {
      tags: [:name] # include tags from model association
    },
    using: { tsearch: { prefix: true } }
    
  # TODO: next search iteration: add a global search controller instead with multisearchable
  multisearchable against: [:title, :category, :place, :price, :capacity],
   using: {
      tsearch: { prefix: true } # prefix: true = partial matches
    }
end
