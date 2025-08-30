class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :world

  ## Validations
  validates :status, presence: true, inclusion: { in: %w[pending confirmed canceled] }
  validates :start_date, presence: true
  validates :end_date, presence: true

  ## Model methods
  before_save :calculate_total_price
  # Accept & Decline booking => updates Booking.id DB status
  def accept!
    update!(status: "confirmed") 
  end

  def decline!
    update!(status: "canceled")   
  end

  private

  def calculate_total_price
    if start_date && end_date
      nights = (end_date - start_date).to_i
      self.total_price = nights * world.price * world.capacity
    end
  end
end
