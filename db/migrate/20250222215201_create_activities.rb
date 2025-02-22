class CreateActivities < ActiveRecord::Migration[8.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.string :difficulty_level
      t.integer :duration
      t.integer :price

      t.timestamps
    end
  end
end
