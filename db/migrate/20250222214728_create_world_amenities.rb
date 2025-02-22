class CreateWorldAmenities < ActiveRecord::Migration[8.0]
  def change
    create_table :world_amenities do |t|
      t.references :world, null: false, foreign_key: true
      t.references :amenity, null: false, foreign_key: true
      t.boolean :exclusive

      t.timestamps
    end
  end
end
