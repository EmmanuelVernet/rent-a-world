class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :world

  validates :status, presence: true, inclusion: { in: %w[pending confirmed canceled] }
  validates :start_date, presence: true
  validates :end_date, presence: true

  # Accept & Decline booking
  def accept!
    update!(status: "confirmed") 
  end

  def decline!
    update!(status: "canceled")   
  end

end
