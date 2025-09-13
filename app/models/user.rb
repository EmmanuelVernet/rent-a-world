class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :worlds, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :phone, presence: true
  validates :user_description, presence: true

  enum :role, %i[rentee renter admin] # allows for current_user.admin?
  before_validation :set_default_role, on: :create

  # Model methods
  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def set_default_role
    self.role ||= :rentee
  end

end
