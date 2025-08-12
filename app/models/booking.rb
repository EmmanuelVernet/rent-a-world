class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :world

  validates :status, presence: true, inclusion: { in: %w[pending confirmed canceled] }
  validates :start_date, presence: true
  validates :end_date, presence: true
end
