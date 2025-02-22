class CreateWorldActivities < ActiveRecord::Migration[8.0]
  def change
    create_table :world_activities do |t|
      t.references :activity, null: false, foreign_key: true
      t.references :world, null: false, foreign_key: true

      t.timestamps
    end
  end
end
