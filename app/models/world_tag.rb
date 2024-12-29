class WorldTag < ApplicationRecord
  belongs_to :world_id
  belongs_to :tag_id
end
