class Review < ApplicationRecord
  belongs_to :user_id
  belongs_to :world_id

  validates :comment, presence: true, length: { minimum: 5 }
  validates :stars, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
