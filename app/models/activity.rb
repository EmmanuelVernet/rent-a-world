class Activity < ApplicationRecord
  has_many :world_activities, dependent: :destroy
  has_many :worlds, through: :world_activities

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { minimum: 5 }
  validates :difficulty_level, inclusion: { in: %w[Easy Medium Hard], message: "%{value} is not a valid difficulty" }
  validates :duration, numericality: { only_integer: true, greater_than: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
