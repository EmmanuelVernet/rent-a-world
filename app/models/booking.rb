class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :world

  ## Validations
  validates :status, presence: true, inclusion: { in: %w[pending confirmed canceled] } #=> this should ideally be an enum to get pending? confirmed? methods
  validates :start_date, presence: true
  validates :end_date, presence: true

  # Associations
  ## Notifications
  has_many :noticed_events, as: :record, dependent: :destroy, class_name: "Noticed::Event" # Who receives the notification
  has_many :notifications, through: :noticed_events, class_name: "Noticed::Notification" # What the notification was about, eg: in case user is mentioned in comment, it references data about them


  ## Model methods
  before_save :calculate_total_price
  # Accept & Cancel booking => updates Booking.id DB status
  def accept!
    update!(status: "confirmed") 
  end

  def cancel!
    update!(status: "canceled")   
  end

  def canceled?
    status == "canceled"
  end

  private

  def calculate_total_price
    if start_date && end_date
      nights = (end_date - start_date).to_i
      self.total_price = nights * world.price * world.capacity
    end
  end
end
