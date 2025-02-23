class Tag < ApplicationRecord
  has_many :world_tags, dependent: :destroy
  has_many :worlds, through: :world_tags

  validates :name, presence: true, uniqueness: true
end
