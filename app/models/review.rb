class Review < ApplicationRecord
  belongs_to :user_id
  belongs_to :world_id
end
