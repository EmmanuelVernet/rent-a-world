class Conversation < ApplicationRecord
  belongs_to :world
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  has_many :messages, dependent: :destroy
  has_rich_text :message

  # Validations
  #  validates :sender_id, uniqueness: { scope: [:recipient_id, :world_id] }
end
